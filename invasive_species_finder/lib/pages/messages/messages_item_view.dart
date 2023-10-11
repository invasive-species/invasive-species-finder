import 'package:flutter/material.dart';

import '../../data_model/message_db.dart';
import '../../components/user_avatar.dart';
import '../../data_model/user_db.dart';

class MessageItemView extends StatelessWidget {
  const MessageItemView({Key? key, required this.messageID}) : super(key: key);

  final String messageID;

  @override
  Widget build(BuildContext context) {
    MessageData data = messageDB.getMessages(messageID);
    String replierName = userDB.getUser(data.replierId).name;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                leading: UserAvatar(userID: data.replierId),
                trailing: const Icon(Icons.more_vert),
                title: Text(replierName,
                    style: Theme.of(context).textTheme.titleLarge),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Content: ${data.content}')),
              ),
              const SizedBox(height: 10)
            ],
          )),
    );
  }
}
