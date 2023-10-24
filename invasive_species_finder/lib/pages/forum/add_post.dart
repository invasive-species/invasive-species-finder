import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invasive_species_finder/components/help_button.dart';
import 'package:invasive_species_finder/data_model/forum_post_db.dart';
import 'package:invasive_species_finder/data_model/location_db.dart';
import 'package:invasive_species_finder/data_model/species_db.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:invasive_species_finder/pages/forum/form-fields/reset_button.dart';
import 'package:invasive_species_finder/pages/forum/form-fields/submit_button.dart';
import 'package:invasive_species_finder/pages/forum/forum_view.dart';

import '../../data_model/user_db.dart';
import 'form-fields/body_field.dart';
import 'form-fields/date_field.dart';
import 'form-fields/location_dropdown_field.dart';
import 'form-fields/photo_field.dart';
import 'form-fields/post_title_field.dart';
import 'form-fields/species_dropdown_field.dart';

class AddPost extends ConsumerWidget {
  AddPost({
    super.key,
  });
  final String title = 'Add Post';
  static const routeName = '/addPost';
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
    List<String> locationNames = locationDB.getLocationNames();
    List<String> speciesNames = speciesDB.getSpeciesNames();

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      // Since validation passed, we can safely access the values.
      String title = _titleFieldKey.currentState?.value;
      String body = _bodyFieldKey.currentState?.value;
      String date = _dateFieldKey.currentState?.value;
      String imageFileName = _photoFieldKey.currentState?.value;
      String locationID =
          locationDB.getLocationIDFromName(_locationFieldKey.currentState?.value);
      String speciesID = speciesDB.getSpeciesIDFromName(_speciesFieldKey.currentState?.value);
      // Add the new post.
      postDB.addPost(
          title: title,
          body: body,
          date: date,
          imageFileName: imageFileName,
          locationID: locationID,
          userID: currentUserID,
          speciesID: speciesID,);
      Navigator.pushReplacementNamed(context, ForumView.routeName);
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Post'),
          actions: const [HelpButton(routeName: AddPost.routeName)],
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
                      PostTitleField(fieldKey: _titleFieldKey),
                      BodyField(fieldKey: _bodyFieldKey),
                      PhotoField(fieldKey: _photoFieldKey),
                      LocationDropdownField(
                          fieldKey: _locationFieldKey,
                          locationNames: locationNames),
                      SpeciesDropdownField(
                          fieldKey: _speciesFieldKey,
                          speciesNames: speciesNames),
                      DateField(fieldKey: _dateFieldKey),

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
