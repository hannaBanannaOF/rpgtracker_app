import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomInput extends StatelessWidget {
  final String? label;
  final String name;
  final bool required;
  final String? requiredText;
  final String? initialValue;
  final TextInputType keyboardType;
  const CustomInput(
      {super.key,
      required this.name,
      this.label,
      this.required = false,
      this.requiredText,
      this.initialValue,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      keyboardType: keyboardType,
      name: name,
      decoration: InputDecoration(label: label != null ? Text(label!) : null),
      initialValue: initialValue,
      validator: required
          ? FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: requiredText),
            ])
          : null,
    );
  }
}
