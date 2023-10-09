// list_view_action.dart
import 'package:flutter/material.dart';
import '../signup/signup_view.dart'; // placeholder for detail page

void navigateToDetailPage(BuildContext context, String title) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const SignupView(),
    ),
  );
}
