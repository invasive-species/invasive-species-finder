import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/forum_post_db.dart';

final forumPostDBProvider = Provider<ForumPostDB>((ref) {
  return ForumPostDB(ref);
});
