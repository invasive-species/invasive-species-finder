import 'message.dart';

class MessageCollection {
  MessageCollection(messages) : _messages = messages;

  final List<Message> _messages;

  Message getMessage(String messageID) {
    return _messages.firstWhere((data) => data.id == messageID);
  }

  int size() {
    return _messages.length;
  }

  List<String> getMessageIDs() {
    return _messages.map((data) => data.id).toList();
  }

  List<String> getAssociatedMessageIDs(String userID) {
      return getMessageIDs()
          .where((messageID) => getMessage(messageID).userID == userID)
          .toList();

  }
}
