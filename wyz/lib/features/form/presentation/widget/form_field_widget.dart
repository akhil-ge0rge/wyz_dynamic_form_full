import 'package:flutter/material.dart';
import 'package:wyz/core/helper/hex_color.dart';
import 'package:wyz/features/form/domain/entities/form_fields.dart' as domain;
import 'package:wyz/features/form/presentation/provider/form_provider.dart';
import 'package:wyz/features/form/presentation/widget/custom_widgets/custom_check_box.dart';
import 'package:wyz/features/form/presentation/widget/custom_widgets/custom_date_picker.dart';
import 'package:wyz/features/form/presentation/widget/custom_widgets/custom_radio_button.dart';
import 'package:wyz/features/form/presentation/widget/custom_widgets/custom_slider.dart';
import 'package:wyz/features/form/presentation/widget/custom_widgets/custom_text_field.dart';

import 'custom_widgets/custom_drop_down.dart';

class DynamicFormFieldWidget extends StatelessWidget {
  final domain.FormField field;
  final FormProvider formProvider;
  const DynamicFormFieldWidget(
      {super.key, required this.field, required this.formProvider});

  @override
  Widget build(BuildContext context) {
    Color? fieldColor;
    FontWeight? fontWeight;
    if (field.color != null) {
      //convert hexcolor string to [Color] if its available
      fieldColor = HexColor.fromHex(field.color!);
    }
    if (field.size != null) {
      //convert fontWeight if its available
      final size = field.size?.toLowerCase();
      switch (size) {
        case "small":
          fontWeight = FontWeight.w300;
        case "medium":
          fontWeight = FontWeight.w400;
        case "large":
          fontWeight = FontWeight.w700;
      }
    }

    switch (field.type.toLowerCase()) {
      //Return Custom Form Fields Based On Their type
      case 'textbox':
        return CustomTextField(
          field: field,
          fieldColor: fieldColor,
          formProvider: formProvider,
          fontWeight: fontWeight,
        );
      case 'dropdown':
        List<String> options = field.options ?? [];
        String? currentValue = formProvider.formValues[field.id];
        return CustomDropDown(
          field: field,
          fieldColor: fieldColor,
          formProvider: formProvider,
          options: options,
          currentValue: currentValue,
          fontWeight: fontWeight,
        );
      case 'checkbox':
        bool currentValue = formProvider.formValues[field.id] ?? false;
        return CustomCheckBox(
          field: field,
          formProvider: formProvider,
          currentValue: currentValue,
          fontWeight: fontWeight,
        );
      case 'slider':
        final double min = field.min ?? 0.0;
        final double max = field.max ?? 100.0;
        final double currentSliderValue =
            formProvider.formValues[field.id] is double
                ? formProvider.formValues[field.id]
                : min;
        return CustomSlider(
          currentSliderValue: currentSliderValue,
          field: field,
          max: max,
          min: min,
          fieldColor: fieldColor,
          formProvider: formProvider,
          fontWeight: fontWeight,
        );
      case 'date':
        String? currentDateString = formProvider.formValues[field.id];
        DateTime initialDate = currentDateString != null
            ? (DateTime.tryParse(currentDateString) ?? DateTime.now())
            : DateTime.now();
        return CustomDatePicker(
          fieldColor: fieldColor,
          initialDate: initialDate,
          formProvider: formProvider,
          field: field,
          currentDateString: currentDateString,
          fontWeight: fontWeight,
        );
      case 'radio':
        List<String> options = field.options ?? [];
        String? currentValue = formProvider.formValues[field.id];
        return CustomRadioButton(
          currentValue: currentValue,
          fieldColor: fieldColor,
          options: options,
          field: field,
          formProvider: formProvider,
          fontWeight: fontWeight,
        );
      default:
        return Container();
    }
  }
}
