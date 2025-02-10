import 'package:flutter/material.dart';
import 'package:wyz/features/form/presentation/provider/form_provider.dart';

class SubmitAlertDialog extends StatelessWidget {
  final FormProvider provider;
  const SubmitAlertDialog({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Form Submission Data"),
      content: SizedBox(
        height: 200.0,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: provider.formValues.length,
          itemBuilder: (context, index) {
            final nameById = provider.appResponse?.data?.fields.where(
              (element) =>
                  element.id == provider.formValues.keys.elementAt(index),
            );
            return Text(
              "${provider.formValues.keys.elementAt(index)} - ${nameById?.first.label} - ${provider.formValues.values.elementAt(index)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        )
      ],
    );
  }
}
