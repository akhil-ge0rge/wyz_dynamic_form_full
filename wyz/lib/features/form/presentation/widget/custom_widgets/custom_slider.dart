import 'package:flutter/material.dart';
import 'package:wyz/features/form/domain/entities/form_fields.dart' as domain;
import 'package:wyz/features/form/presentation/provider/form_provider.dart';

//Create a custom slider
// with range and display current slider value
//with a label and validate if its required
class CustomSlider extends StatelessWidget {
  final double currentSliderValue;
  final FormProvider formProvider;
  final domain.FormField field;
  final double max;
  final double min;
  final Color? fieldColor;
  final FontWeight? fontWeight;

  const CustomSlider(
      {super.key,
      required this.currentSliderValue,
      required this.field,
      required this.max,
      required this.min,
      required this.fieldColor,
      required this.formProvider,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FormField<double>(
        initialValue: currentSliderValue,
        validator: (value) {
          // make sure a value is selected if required
          if (field.validation != null &&
              field.validation!.required &&
              value == null) {
            return field.validation!.errorMessage ??
                "Please select ${field.label}.";
          }
          return null;
        },
        builder: (FormFieldState<double> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shows the field label with the current slider value
              Text(
                "${field.label}: ${currentSliderValue.toStringAsFixed(0)}",
                style: TextStyle(
                  color: fieldColor,
                  fontWeight: fontWeight,
                ),
              ),
              Slider(
                value: currentSliderValue,
                min: min,
                max: max,
                label: currentSliderValue.toStringAsFixed(0),
                onChanged: (value) {
                  formProvider.updateFieldValue(field.id, value);
                  // updates validation state
                  state.didChange(value);
                },
              ),
              // if validation fails it display an error message
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
