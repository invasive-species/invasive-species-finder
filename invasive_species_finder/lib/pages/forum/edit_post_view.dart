import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/components/help_button.dart';
import 'package:invasive_species_finder/data_model/forum_post_db.dart';
import 'package:invasive_species_finder/data_model/location_db.dart';
import 'package:invasive_species_finder/data_model/species_db.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:invasive_species_finder/pages/forum/form-fields/body_field.dart';
import 'package:invasive_species_finder/pages/forum/form-fields/date_field.dart';
import 'package:invasive_species_finder/pages/forum/form-fields/location_dropdown_field.dart';
import 'package:invasive_species_finder/pages/forum/form-fields/photo_field.dart';
import 'package:invasive_species_finder/pages/forum/form-fields/post_title_field.dart';

import '../../data_model/user_db.dart';
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
  Widget build(BuildContext context, WidgetRef ref) {
    final LocationDB locationDB = ref.watch(locationDBProvider);
    final SpeciesDB speciesDB = ref.watch(speciesDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    final ForumPostDB postDB = ref.watch(forumPostDBProvider);
    String postID = ModalRoute.of(context)?.settings.arguments as String;
    ForumPostData postData = postDB.getPosts(postID);
    List<String> locationNames = locationDB.getLocationNames();
    List<String> speciesNames = speciesDB.getSpeciesNames();
    String currentLocationName = locationDB.getLocations(postData.locationID).name;
    String currentSpeciesName = speciesDB.getSpecies(postData.speciesID).name;

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      // Since validation passed, we can safely access the values.
      String title = _titleFieldKey.currentState?.value;
      String body = _bodyFieldKey.currentState?.value;
      String date = _dateFieldKey.currentState?.value;
      String imagePath = _photoFieldKey.currentState?.value;
      String locationID =
          locationDB.getLocationIDFromName(_locationFieldKey.currentState?.value);
      String speciesID = speciesDB.getSpeciesIDFromName(_speciesFieldKey.currentState?.value);
      // Add the new post.
      postDB.updatePost(
          id: postID,
          title: title,
          body: body,
          date: date,
          imagePath: imagePath,
          locationID: locationID,
          userID: currentUserID,
          speciesID: speciesID);
      Navigator.pushReplacementNamed(context, ForumView.routeName);
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
