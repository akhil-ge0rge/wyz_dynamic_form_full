import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wyz/features/form/presentation/provider/form_provider.dart';

import '../../../domain/entities/form_fields.dart' as domain;

//A TextField with [Label Text] & [Hint Text]
//validation like required , mix & max character count
//and regex pattern validation
class CustomTextField extends StatelessWidget {
  final domain.FormField field;
  final Color? fieldColor;
  final FormProvider formProvider;
  final FontWeight? fontWeight;
  const CustomTextField({
    super.key,
    required this.field,
    required this.fontWeight,
    this.fieldColor,
    required this.formProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        //adding hint and label text
        decoration: InputDecoration(
          labelText: field.label,
          hintText: field.placeholder,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: fieldColor ?? Colors.black, width: 3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
        style: TextStyle(color: fieldColor, fontWeight: fontWeight),
        onChanged: (value) {
          formProvider.updateFieldValue(field.id, value);
        },
        validator: (value) {
          //If Validation Check is Avaialbe TextField Check Based on
          //[required] [minLength] [maxLength] [regex pattern matching]
          if (field.validation != null) {
            //Required
            if (field.validation!.required &&
                (value == null || value.trim().isEmpty)) {
              return "${field.label} is required.";
            }
            // Minimum length check.
            if (field.validation!.minLength != null &&
                value != null &&
                value.length < field.validation!.minLength!) {
              return "${field.label} must be at least ${field.validation!.minLength} characters.";
            }
            // Maximum length check.
            if (field.validation!.maxLength != null &&
                value != null &&
                value.length > field.validation!.maxLength!) {
              return "${field.label} must be at most ${field.validation!.maxLength} characters.";
            }
            // Pattern matching check.
            if (field.validation!.pattern != null && value != null) {
              final regex = RegExp(field.validation!.pattern!);
              log(field.validation!.pattern.toString());
              log((!regex.hasMatch(value)).toString());
              if (!regex.hasMatch(value)) {
                return field.validation!.errorMessage ??
                    "${field.label} is invalid.";
              }
            }
          }
          return null;
        },
      ),
    );
  }
}
