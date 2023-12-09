import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invasive_species_finder/features/message/presentation/messages_view.dart';

import '../../user/presentation/user_avatar.dart';



class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  // build a list of users list except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('error');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading...");
        }

        // Check if snapshot.data is not null
        if (snapshot.data != null) {
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 1,
                vertical: 5,
              ),
              child: _buildUserListItem(doc),
            ))
                .toList(),
          );
        } else {
          // Handle the case when snapshot.data is null
          return const Text("No data available");
        }
      },
    );
  }


  // build individual user List items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users except current user
    if (_auth.currentUser!.email! != data['id']) {
      return ListTile(
        title: Text(data['name']),
        leading: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: UserAvatar(userID: data['id']),
          /*const CircleAvatar(
            radius: 35,
            child: Icon(Icons.person),
          ),*/
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessagesView(
                receiverUserID: data['id'],
              ),
            ),
          );
        },
      );
    }
    return Container();
  }
}
