import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/data/post_providers.dart';
import '../data/message_providers.dart';
import 'messages_item_view.dart';
import '../domain/message_db.dart';

/// Displays a list of Gardens.
class MessagesView extends ConsumerWidget {
  const MessagesView({
    super.key,
  });

  final String title = 'Messages';
  static const routeName = '/messages';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final MessageDB messageDB = ref.watch(messageDBProvider);
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
