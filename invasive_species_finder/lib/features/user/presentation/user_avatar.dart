import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/features/common/all_data_provider.dart';
import 'package:invasive_species_finder/features/common/isf_loading.dart';

import '../../common/isf_error.dart';
import '../domain/user.dart';
import '../domain/user_collection.dart';

/// Returns a CircleAvatar with either an image if available or initials, plus a label.
class UserAvatar extends ConsumerWidget {
  const UserAvatar({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(users: allData.users),
        loading: () => const ISFLoading(),
        error: (error, st) => ISFError(error.toString(), st.toString()));
  }

  Widget _build({required List<User> users}) {
    UserCollection userCollection = UserCollection(users);
    User user = userCollection.getUser(userID);
    bool hasImagePath = user.imagePath != null;
    return
      (hasImagePath) ?
      CircleAvatar(
        backgroundImage: AssetImage(user.imagePath!),
      ) :
      CircleAvatar(
        child: Text(user.initials),
      );
  }
}
