import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A text field to provide a description.
class BodyField extends StatelessWidget {
  const BodyField(
      {super.key, required this.fieldKey, this.currBody});

  final String? currBody;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Body';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currBody,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "I found this species around my house, and I think it is invasive. Can someone verify?"',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
