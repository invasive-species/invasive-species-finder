import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/message_db.dart';

final messageDBProvider = Provider<MessageDB>((ref) {
  return MessageDB(ref);
});
