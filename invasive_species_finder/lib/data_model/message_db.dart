
/// The data associated with messages.
class MessageData {
  MessageData({
    required this.id,
    required this.userID,
    required this.content,
  });

  String id;
  String userID;
  String content;
}

/// Provides access to and operations on all defined users.
class MessageDB {
  final List<MessageData> _messages = [
    MessageData(
      id: 'message-001',
      userID: 'user-001',
      content: 'species-001',
    ),
    MessageData(
      id: 'message-002',
      userID: 'user-001',
      content: 'species-002',
    ),
    MessageData(
      id: 'message-003',
      userID: 'user-001',
      content: 'species-003',
    ),
    MessageData(
      id: 'message-004',
      userID: 'user-002',
      content: 'species-001',
    ),
    MessageData(
      id: 'message-005',
      userID: 'user-002',
      content: 'species-002',
    ),
    MessageData(
      id: 'message-006',
      userID: 'user-003',
      content: 'species-001',
    ),
  ];

  List<String> getMessageIDs() {
    return _messages.map((data) => data.id).toList();
  }

  MessageData getMessages(messageID) {
    return _messages.firstWhere((data) => data.id == messageID);
  }

  List<String> getAssociatedMessageIDs(String userID) {
    return getMessageIDs()
        .where((messageID) => getMessages(messageID).userID == userID)
        .toList();
  }
}

MessageDB messageDB = MessageDB();
