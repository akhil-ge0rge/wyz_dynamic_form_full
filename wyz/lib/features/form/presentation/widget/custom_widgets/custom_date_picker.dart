import 'package:flutter/material.dart';
import 'package:wyz/features/form/domain/entities/form_fields.dart' as domain;
import 'package:wyz/features/form/presentation/provider/form_provider.dart';

//custom datePicker with textformfield
//to display selected date and
//prevent manual input typing
class CustomDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final FormProvider formProvider;
  final String? currentDateString;
  final domain.FormField field;
  final Color? fieldColor;
  final FontWeight? fontWeight;
  const CustomDatePicker({
    super.key,
    required this.fieldColor,
    required this.fontWeight,
    required this.initialDate,
    required this.formProvider,
    required this.field,
    required this.currentDateString,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () async {
          // Show date picker dialog
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            formProvider.updateFieldValue(
              field.id,
              pickedDate.toIso8601String(),
            );
          }
        },
        //Wraped [TextFormField] With [AbsorbPointer] to block interaction
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: field.label,
              hintText: field.placeholder ?? "Select Date",
              border: const OutlineInputBorder(),
            ),
            // [TextEditingController] to show the selected date in YYYY-MM-DD format
            controller: TextEditingController(
              text: currentDateString != null
                  ? (DateTime.tryParse(currentDateString!)
                          ?.toLocal()
                          .toString()
                          .split(' ')[0] ??
                      '')
                  : '',
            ),
            style: TextStyle(
              color: fieldColor,
              fontWeight: fontWeight,
            ),
            validator: (value) {
              if (field.validation != null &&
                  field.validation!.required &&
                  (value == null || value.isEmpty)) {
                return field.validation!.errorMessage ??
                    "Please select ${field.label}.";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
