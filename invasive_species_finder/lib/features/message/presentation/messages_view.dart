import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/message/domain/message.dart';
import 'package:invasive_species_finder/features/message/domain/message_collection.dart';

import '../../common/all_data_provider.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import 'messages_item_view.dart';

/// Displays a list of Gardens.
class MessagesView extends ConsumerWidget {
  const MessagesView({
    super.key,
  });

  final String title = 'Messages';
  static const routeName = '/messages';

  @override
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        messages: allData.messages,
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  _build({
    required BuildContext context,
    required String currentUserID,
    required List<Message> messages,
}) {
    MessageCollection messageCollection = MessageCollection(messages);
    List<String> messageIDs = messageCollection.getAssociatedMessageIDs(currentUserID);
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
