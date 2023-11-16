import 'package:invasive_species_finder/features/forum/data/forum_post_providers.dart';
import 'package:invasive_species_finder/features/forum/domain/forum_post.dart';
import 'package:invasive_species_finder/features/location/data/location_providers.dart';
import 'package:invasive_species_finder/features/message/data/message_providers.dart';
import 'package:invasive_species_finder/features/message/domain/message.dart';
import 'package:invasive_species_finder/features/species/data/species_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../location/domain/location.dart';
import '../species/domain/species.dart';
import '../user/data/user_providers.dart';
import '../user/domain/user.dart';


part 'all_data_provider.g.dart';

// Based on: https://stackoverflow.com/questions/69929734/combining-futureproviders-using-a-futureprovider-riverpod

class AllData {
  AllData(
      {required this.posts,
      required this.messages,
      required this.users,
      required this.locations,
        required this.species,
        required this.currentLocationIDs,
      required this.currentUserID});

  final List<ForumPost> posts;
  final List<Message> messages;
  final List<User> users;
  final List<Location> locations;
  final List<Species> species;
  final List<String> currentLocationIDs;
  final String currentUserID;
}

@riverpod
Future<AllData> allData(AllDataRef ref) async {
  final posts = ref.watch(forumPostsProvider.future);
  final messages = ref.watch(messagesProvider.future);
  final users = ref.watch(usersProvider.future);
  final locations = ref.watch(locationsProvider.future);
  final species = ref.watch(speciesProvider.future);
  final currentLocationIDs = ref.watch(currentLocationIDsProvider.future);
  final currentUserID = ref.watch(currentUserIDProvider);
  return AllData(
      posts: await posts,
      messages: await messages,
      users: await users,
      locations: await locations,
      species: await species,
      currentLocationIDs: await currentLocationIDs,
      currentUserID: currentUserID);
}
