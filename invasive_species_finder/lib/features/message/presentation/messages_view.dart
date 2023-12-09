import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invasive_species_finder/features/message/presentation/typing_field.dart';

import '../domain/chat_service.dart';
import 'message_bubble.dart';


/// Displays a list of Gardens.
class MessagesView extends StatefulWidget {
  final String receiverUserID;
  const MessagesView({
    required this.receiverUserID,
    super.key,
  });

  final String title = 'Messages';

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late String receiverName;
  late String receiverImagePath;

  Future<DocumentSnapshot?> getUserInformation(String id) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Query to find the user by id
    QuerySnapshot querySnapshot = await users.where('id', isEqualTo: id).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDocument = querySnapshot.docs.first;
      return userDocument;
    } else {
      return null;
    }
  }

  Future<String?> getSenderName(String senderId) async {
    DocumentSnapshot? senderSnapshot = await getUserInformation(senderId);
    return (senderSnapshot?.data() as Map<String, dynamic>?)?['name'];
  }


  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
        widget.receiverUserID,
        messageController.text,
      );
    }
    // clear the controller
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot?>(
          future: getUserInformation(widget.receiverUserID),
          builder: (context, snapshot) {
            receiverImagePath = snapshot.data?['imagePath'] ?? '';
            receiverName = snapshot.data?['name'] ?? '';
            return Row(
              children: [
                (receiverImagePath != '') ?
                CircleAvatar(backgroundImage: AssetImage(receiverImagePath))
                    : const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 8),
                Text(receiverName),
              ],
            );
            //  }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: chatService.getMessages(
        widget.receiverUserID,
        firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.docs.map((document) {
            return _buildMessageItem(document);
          }).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment =
    (data['senderId'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var sendOrReceiver =
    (data['senderId'] == firebaseAuth.currentUser!.uid) ? "sender" : "receiver";

    return FutureBuilder<String?>(
      future: getSenderName(data['senderId']),
      builder: (context, senderSnapshot) {
        //var senderName = senderSnapshot.data ?? 'Unknown';

        return Container(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: (data['senderId'] ==
                  firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (data['timestamp'] as Timestamp?) != null
                          ? DateFormat.yMd().add_jm().format((data['timestamp'] as Timestamp).toDate())
                          : "01:00",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: (data['senderId'] ==
                      firebaseAuth.currentUser!.uid)
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  /*children: [
                    Text(
                      sendOrReceiver == "sender"
                          ? senderName
                          : receiverName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ], */
                ),
                ChatBubble(message: data['message'], align: sendOrReceiver),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildMessageInput() {
    return Row(
      children: [
        const SizedBox(width: 5),
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: TypingField(
            controller: messageController,
            hintText: 'Write message...',
            obscureText: false,
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
            size: 18,
          ),
        ),
      ],
    );
  }
}
