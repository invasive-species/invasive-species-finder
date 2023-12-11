import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:invasive_species_finder/features/common/all_data_provider.dart';
import 'package:invasive_species_finder/features/message/domain/chat_service.dart';
import 'package:invasive_species_finder/features/message/presentation/typing_field.dart';
import 'package:invasive_species_finder/features/species/domain/species_collection.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../../location/domain/location.dart';
import '../../location/domain/location_collection.dart';
import '../../species/domain/species.dart';
import '../domain/forum_post.dart';
import '../domain/forum_post_collection.dart';

class PostDetail extends ConsumerWidget {
  final String postID;

  const PostDetail({
    required this.postID,
    Key? key,
  }) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        posts: allData.posts,
        species: allData.species,
        locations: allData.locations,
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  _build({
    required BuildContext context,
    required String currentUserID,
    required List<Species> species,
    required List<Location> locations,
    required List<ForumPost> posts}){
    ForumPostCollection postCollection = ForumPostCollection(posts);
    ForumPost data = postCollection.getPost(postID);
    SpeciesCollection speciesCollection = SpeciesCollection(species);
    LocationCollection locationCollection = LocationCollection(locations);
    Species speciesData = speciesCollection.getSpecies(data.speciesID);
    Location locationData = locationCollection.getLocation(data.locationID);
    String speciesName = speciesData.name;
    String locationName = locationData.name;
    final TextEditingController messageController = TextEditingController();
    final ChatService chatService = ChatService();

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    data.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  data.date,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  'Last updated: ${data.lastUpdate}',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  'Location: $locationName',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  'Species: $speciesName',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        data.body,
        softWrap: true,
      ),
    );

    Widget commentSection = Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.yMd().add_jm().format(DateTime.now()),
                  ),
                ]
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'I found this around my house as well!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );

    void sendMessage() async {
      if(messageController.text.isNotEmpty){
        await chatService.sendMessage(
          currentUserID,
          messageController.text,
        );
      }
      messageController.clear();
    }

    Widget buildMessageInput(){
      return Row(
        children: [
          const SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TypingField(
              controller: messageController,
              hintText: 'Write message...',
              obscureText: false,
            ),
          ),
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send,
                size: 18,
                color: Colors.blue,
              )
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: ListView(
        children: [
          Image.asset(
            data.imagePath,
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          textSection,
          const SizedBox(height: 10),
          const Text(
              'Comments',
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )
          ),
          const SizedBox(height: 10),
          commentSection,
          const SizedBox(height: 70),
          buildMessageInput(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
