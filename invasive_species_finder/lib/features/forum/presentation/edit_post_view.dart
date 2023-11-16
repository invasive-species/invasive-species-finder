import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:invasive_species_finder/features/forum/presentation/edit_post_controller.dart';
import 'package:invasive_species_finder/features/help/presentation/help_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:invasive_species_finder/features/forum/presentation/form-fields/body_field.dart';
import 'package:invasive_species_finder/features/forum/presentation/form-fields/date_field.dart';
import 'package:invasive_species_finder/features/forum/presentation/form-fields/location_dropdown_field.dart';
import 'package:invasive_species_finder/features/forum/presentation/form-fields/photo_field.dart';
import 'package:invasive_species_finder/features/forum/presentation/form-fields/post_title_field.dart';
import 'package:invasive_species_finder/features/location/domain/location_collection.dart';

import '../../common/all_data_provider.dart';
import '../../common/global_snackbar.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../../location/domain/location.dart';
import '../../species/domain/species.dart';
import '../../species/domain/species_collection.dart';
import '../../user/domain/user.dart';
import '../domain/forum_post.dart';
import '../domain/forum_post_collection.dart';
import 'form-fields/reset_button.dart';
import 'form-fields/species_dropdown_field.dart';
import 'form-fields/submit_button.dart';
import 'forum_view.dart';

class EditPostView extends ConsumerWidget {
  EditPostView({
    super.key,
  });
  final String title = 'Edit Post';
  static const routeName = '/editPostView';
  final _formKey = GlobalKey<FormBuilderState>();
  final _titleFieldKey = GlobalKey<FormBuilderFieldState>();
  final _bodyFieldKey = GlobalKey<FormBuilderFieldState>();
  final _dateFieldKey = GlobalKey<FormBuilderFieldState>();
  final _photoFieldKey = GlobalKey<FormBuilderFieldState>();
  final _locationFieldKey = GlobalKey<FormBuilderFieldState>();
  final _speciesFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  build(BuildContext context, WidgetRef ref){
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        currentUserID: allData.currentUserID,
        posts: allData.posts,
        users: allData.users,
        locations: allData.locations,
        species: allData.species,
        ref: ref,
      ),
      error: (err, stack) => ISFError(err.toString(), stack.toString()),
      loading: () => const ISFLoading(),
    );
  }

  _build({
    required BuildContext context,
    required String currentUserID,
    required List<ForumPost> posts,
    required List<User> users,
    required List<Location> locations,
    required List<Species> species,
    required WidgetRef ref,
}) {
    LocationCollection locationCollection = LocationCollection(locations);
    SpeciesCollection speciesCollection = SpeciesCollection(species);
    ForumPostCollection postCollection = ForumPostCollection(posts);

    String postID = ModalRoute.of(context)?.settings.arguments as String;
    ForumPost postData = postCollection.getPost(postID);
    List<String> locationNames = locationCollection.getLocationNames();
    List<String> speciesNames = speciesCollection.getSpeciesNames();
    String currentLocationName = locationCollection.getLocation(postData.locationID).name;
    String currentSpeciesName = speciesCollection.getSpecies(postData.speciesID).name;

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      // Since validation passed, we can safely access the values.
      String title = _titleFieldKey.currentState?.value;
      String body = _bodyFieldKey.currentState?.value;
      String date = _dateFieldKey.currentState?.value;
      String imagePath = _photoFieldKey.currentState?.value;
      String locationID =
          locationCollection.getLocationIDFromName(_locationFieldKey.currentState?.value);
      String speciesID = speciesCollection.getSpeciesIDFromName(_speciesFieldKey.currentState?.value);
      String lastUpdate = DateFormat.yMd().format(DateTime.now());
      // Add the new post.
      ForumPost post = ForumPost(
          id: postID,
          title: title,
          body: body,
          date: date,
          imagePath: imagePath,
          locationID: locationID,
          lastUpdate: lastUpdate,
          userID: currentUserID,
          speciesID: speciesID);
      ref.read(editPostControllerProvider.notifier).updatePost(
          post: post,
          onSuccess: (){
            Navigator.pushReplacementNamed(context, ForumView.routeName);
            GlobalSnackBar.show('Post "$title" updated.');
          });
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Post'),
          actions: const [HelpButton(routeName: EditPostView.routeName)],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            Column(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      PostTitleField(
                        fieldKey: _titleFieldKey,
                        currTitle: postData.title,),
                      BodyField(
                        fieldKey: _bodyFieldKey,
                        currBody: postData.body,),
                      PhotoField(
                        fieldKey: _photoFieldKey,
                        currPhoto: postData.imagePath,),
                      LocationDropdownField(
                        fieldKey: _locationFieldKey,
                        locationNames: locationNames,
                        currLocation: currentLocationName,),
                      SpeciesDropdownField(
                        fieldKey: _speciesFieldKey,
                        speciesNames: speciesNames,
                        currSpecies: currentSpeciesName,),
                      DateField(
                        fieldKey: _dateFieldKey,
                        currDate: postData.date,),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SubmitButton(onSubmit: onSubmit),
                    ResetButton(onReset: onReset),
                  ],
                )
              ],
            )
          ],
        )
    );
  }
}
