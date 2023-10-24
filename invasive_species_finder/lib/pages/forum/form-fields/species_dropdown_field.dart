import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A dropdown allowing the user to specify a species.
class SpeciesDropdownField extends StatelessWidget {
  const SpeciesDropdownField(
      {super.key,
      required this.fieldKey,
      required this.speciesNames,
      this.currSpecies});

  final String? currSpecies;
  final List<String> speciesNames;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Species';
    return FieldPadding(
      child: FormBuilderDropdown<String>(
        name: fieldName,
        initialValue: currSpecies,
        key: fieldKey,
        decoration: InputDecoration(
          labelText: fieldName,
        ),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
        items: speciesNames
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
