import 'package:flutter/material.dart';
import 'package:wyz/features/form/domain/entities/form_fields.dart' as domain;
import 'package:wyz/features/form/presentation/provider/form_provider.dart';

//Show a List Of Radio Buttons
//validation on if required
class CustomRadioButton extends StatelessWidget {
  final String? currentValue;
  final domain.FormField field;
  final FormProvider formProvider;
  final List<String> options;
  final Color? fieldColor;
  final FontWeight? fontWeight;
  const CustomRadioButton({
    super.key,
    required this.currentValue,
    required this.fontWeight,
    required this.fieldColor,
    required this.options,
    required this.field,
    required this.formProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FormField<String>(
        initialValue: currentValue,
        validator: (value) {
          //Validation Logic
          if (field.validation != null &&
              field.validation!.required &&
              (value == null || value.isEmpty)) {
            return field.validation!.errorMessage ??
                "Please select ${field.label}.";
          }
          return null;
        },
        builder: (FormFieldState<String> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.label,
                style: TextStyle(
                  color: fieldColor,
                  fontSize: 16,
                  fontWeight: fontWeight,
                ),
              ),
              //Display List of items as [RadioListTile]
              ...options.map((option) => RadioListTile<String>(
                    title: Text(option,
                        style: TextStyle(
                            color: fieldColor, fontWeight: fontWeight)),
                    value: option,
                    groupValue: currentValue,
                    onChanged: (value) {
                      formProvider.updateFieldValue(field.id, value);
                      state.didChange(value);
                    },
                  )),
              //show error if validation failed
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
