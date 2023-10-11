import 'package:flutter/material.dart';

import 'messages_item_view.dart';
import '../../data_model/user_db.dart';
import '../../data_model/message_db.dart';

/// Displays a list of Gardens.
class MessagesView extends StatelessWidget {
  const MessagesView({
    super.key,
  });

  final String title = 'Messages';

  @override
  Widget build(BuildContext context) {
    List<String> messageIDs = messageDB.getAssociatedMessageIDs(currentUserID);
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: (messageIDs.isEmpty)
            ? const Align(
            alignment: Alignment.center,
            child: Text("No messages yet!"))
            : ListView(children: [
          ...messageIDs
              .map((messageID) => MessageItemView(messageID: messageID))
              .toList()
        ]));
  }
}
