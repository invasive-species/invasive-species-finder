import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A text field to input date found.
class DateField extends StatelessWidget {
  const DateField({super.key, required this.fieldKey, this.currDate});

  final String? currDate;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Date';
    DateTime? initialDate;
    if (currDate != null) {
      try {
        initialDate = DateTime.parse(currDate!);
      } catch (e) {
        initialDate = DateTime.now();
      }
    }
    return FieldPadding(
      child: FormBuilderDateTimePicker(
        name: fieldName,
        key: fieldKey,
        decoration: const InputDecoration(
          labelText: 'Select a Date',
          hintText: 'Example: 10/11/2023',
        ),
        initialValue: initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
