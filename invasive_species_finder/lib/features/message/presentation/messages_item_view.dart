import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/message/domain/message_collection.dart';
import 'package:invasive_species_finder/features/user/domain/user_collection.dart';

import '../../common/all_data_provider.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../../user/domain/user.dart';
import '../domain/message.dart';
import '../../user/presentation/user_avatar.dart';


class MessageItemView extends ConsumerWidget {
  const MessageItemView({Key? key, required this.messageID}) : super(key: key);

  final String messageID;

  @override
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        messages: allData.messages,
        users: allData.users,
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  _build({
    required BuildContext context,
    required String currentUserID,
    required List<Message> messages,
    required List<User> users,
  }) {
    MessageCollection messageCollection = MessageCollection(messages);
    Message data = messageCollection.getMessage(messageID);
    UserCollection userCollection = UserCollection(users);
    String replierName = userCollection.getUser(data.replierId).name;

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
