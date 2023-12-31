import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A dropdown allowing the user to specify a location.
class LocationDropdownField extends StatelessWidget {
  const LocationDropdownField(
      {super.key,
      required this.fieldKey,
      required this.locationNames,
      this.currLocation});

  final String? currLocation;
  final List<String> locationNames;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Location';
    return FieldPadding(
      child: FormBuilderDropdown<String>(
        name: fieldName,
        initialValue: currLocation,
        key: fieldKey,
        decoration: InputDecoration(
          labelText: fieldName,
        ),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
        items: locationNames
            .map((name) => DropdownMenuItem(
                  alignment: AlignmentDirectional.centerStart,
                  value: name,
                  child: Text(name),
                ))
            .toList(),
        valueTransformer: (val) => val?.toString(),
      ),
    );
  }
}
