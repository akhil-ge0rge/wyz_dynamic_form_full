import 'package:flutter/material.dart';
import 'package:wyz/features/form/domain/entities/form_fields.dart' as domain;
import 'package:wyz/features/form/presentation/provider/form_provider.dart';

//A DropDown Field with [Display Label] and
//allow user to select an option
//with validation

class CustomDropDown extends StatelessWidget {
  final String? currentValue;
  final domain.FormField field;
  final List<String> options;
  final Color? fieldColor;
  final FormProvider formProvider;
  final FontWeight? fontWeight;

  const CustomDropDown({
    super.key,
    this.currentValue,
    required this.field,
    required this.fontWeight,
    required this.options,
    required this.fieldColor,
    required this.formProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FormField<String>(
        initialValue: currentValue,
        validator: (value) {
          //make sure one of the options from the
          //dropdown is selected if field is [required]
          if (field.validation != null &&
              field.validation!.required &&
              (value == null || value.isEmpty)) {
            return field.validation!.errorMessage ??
                "Please select ${field.label}.";
          }
          return null;
        },
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            //displaying label and error text
            decoration: InputDecoration(
              labelText: field.label,
              border: const OutlineInputBorder(),
              errorText: state.errorText,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentValue,
                isExpanded: true,
                //convert list into [DropDownMenuItem]
                items: options.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(
                      option,
                      style: TextStyle(
                        color: fieldColor,
                        fontWeight: fontWeight,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  // Update [fieldValue] &
                  ///  Notify [FormFieldState] of the value change.
                  formProvider.updateFieldValue(field.id, value);
                  state.didChange(value);
                },
                hint: Text("Select ${field.label}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
