import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/help_db.dart';

part 'help_providers.g.dart';

@riverpod
HelpDB helpDB(HelpDBRef ref) {
  return HelpDB(ref);
}
