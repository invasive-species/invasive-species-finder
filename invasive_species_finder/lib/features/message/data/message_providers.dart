import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/message_database.dart';
import '../domain/message.dart';

part 'message_providers.g.dart';

@riverpod
MessageDatabase messageDatabase(MessageDatabaseRef ref) {
  return MessageDatabase(ref);
}

@riverpod
Stream<List<Message>> messages(MessagesRef ref) {
  final database = ref.watch(messageDatabaseProvider);
  return database.watchMessages();
}
