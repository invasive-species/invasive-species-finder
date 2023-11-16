import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:invasive_species_finder/features/help/presentation/help_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:invasive_species_finder/features/forum/presentation/form-fields/reset_button.dart';
import 'package:invasive_species_finder/features/forum/presentation/form-fields/submit_button.dart';
import 'package:invasive_species_finder/features/forum/presentation/forum_view.dart';

import '../../common/all_data_provider.dart';
import '../../common/global_snackbar.dart';
import '../../common/isf_error.dart';
import '../../common/isf_loading.dart';
import '../../location/domain/location.dart';
import '../../location/domain/location_collection.dart';
import '../../species/domain/species.dart';
import '../../species/domain/species_collection.dart';
import '../../user/domain/user.dart';
import '../domain/forum_post.dart';
import 'edit_post_controller.dart';
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
    required WidgetRef ref}) {
    LocationCollection locationCollection = LocationCollection(locations);
    SpeciesCollection speciesCollection = SpeciesCollection(species);

    List<String> locationNames = locationCollection.getLocationNames();
    List<String> speciesNames = speciesCollection.getSpeciesNames();

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      // Since validation passed, we can safely access the values.
      String title = _titleFieldKey.currentState?.value;
      String body = _bodyFieldKey.currentState?.value;
      String date = _dateFieldKey.currentState?.value;
      String imageFileName = _photoFieldKey.currentState?.value;
      String locationID =
          locationCollection.getLocationIDFromName(_locationFieldKey.currentState?.value);
      String speciesID = speciesCollection.getSpeciesIDFromName(_speciesFieldKey.currentState?.value);
      int numPosts = posts.length;
      String id = 'post-${(numPosts + 1).toString().padLeft(3, '0')}';
      String lastUpdate = DateFormat.yMd().format(DateTime.now());
      // Add the new post.
      ForumPost post = ForumPost(
          id: id,
          title: title,
          body: body,
          date: date,
          imagePath: imageFileName,
          locationID: locationID,
          userID: currentUserID,
          speciesID: speciesID,
          lastUpdate: lastUpdate);
      ref.read(editPostControllerProvider.notifier).updatePost(
          post: post,
          onSuccess: () {
            Navigator.pushReplacementNamed(context, ForumView.routeName);
            GlobalSnackBar.show('Post "$title" added.');
          },
      );
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    Widget addPostForm() => ListView(
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
        );

    AsyncValue asyncUpdate = ref.watch(editPostControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
        actions: const [HelpButton(routeName: AddPost.routeName)],
      ),
      body: asyncUpdate.when(
        data: (data) => addPostForm(),
        loading: () => const ISFLoading(),
        error: (err, stack) => ISFError(err.toString(), stack.toString()),
      )
    );
  }
}
