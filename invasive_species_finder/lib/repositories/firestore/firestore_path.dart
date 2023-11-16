/// Defines the domain model path strings for [FirestoreService].
class FirestorePath {
  static String post(String postID) => 'posts/$postID';
  static String posts() => 'posts';

  static String user(String userID) => 'users/$userID';
  static String users() => 'users';

  static String species(String speciesID) => 'species/$speciesID';
  static String speciess() => 'species';

  static String message(String messageID) => 'messages/$messageID';
  static String messages() => 'messages';

  static String location(String locationID) => 'locations/$locationID';
  static String locations() => 'locations';
}
