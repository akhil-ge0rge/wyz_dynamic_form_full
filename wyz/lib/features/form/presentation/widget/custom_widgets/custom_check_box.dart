import 'package:flutter/material.dart';
import 'package:wyz/features/form/domain/entities/form_fields.dart' as domain;
import 'package:wyz/features/form/presentation/provider/form_provider.dart';

//Create a [CheckBox] with label
// Validate if its required
//
class CustomCheckBox extends StatelessWidget {
  final domain.FormField field;
  final bool currentValue;
  final FormProvider formProvider;
  final Color? fieldColor;
  final FontWeight? fontWeight;
  const CustomCheckBox({
    super.key,
    required this.field,
    required this.currentValue,
    required this.fontWeight,
    required this.formProvider,
    this.fieldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FormField<bool>(
        initialValue: currentValue,
        validator: (value) {
          // make sure the checkbox is selected if required.
          if (field.validation != null &&
              field.validation!.required &&
              value != true) {
            return field.validation!.errorMessage ??
                "You must accept ${field.label}.";
          }
          return null;
        },
        builder: (FormFieldState<bool> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                title: Text(field.label,
                    style: TextStyle(
                      color: fieldColor,
                      fontWeight: fontWeight,
                    )),
                value: currentValue,
                onChanged: (value) {
                  formProvider.updateFieldValue(field.id, value);
                  state.didChange(value);
                },
              ),
              // If validation fails it display an error message
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
