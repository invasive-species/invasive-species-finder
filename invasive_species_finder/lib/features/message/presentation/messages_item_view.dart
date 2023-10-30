import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/message_providers.dart';
import '../domain/message_db.dart';
import '../../user/presentation/user_avatar.dart';
import '../../user/data/post_providers.dart';
import '../../user/domain/user_db.dart';

class MessageItemView extends ConsumerWidget {
  const MessageItemView({Key? key, required this.messageID}) : super(key: key);

  final String messageID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MessageDB messageDB = ref.watch(messageDBProvider);
    MessageData data = messageDB.getMessages(messageID);
    final UserDB userDB = ref.watch(userDBProvider);
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
