import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wyz/core/response/app_response.dart';
import 'package:wyz/features/form/domain/entities/dynamic_form.dart';
import 'package:wyz/features/form/presentation/widget/form_field_widget.dart';
import 'package:wyz/features/form/presentation/widget/skeleton/form_skeleton.dart';
import 'package:wyz/features/form/presentation/widget/submit_alert_dialog.dart';
import '../provider/form_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late FormProvider formProvider;
  //** _formKey helps to validate form data before submitting
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    formProvider = context.read<FormProvider>();

    //[WidgetsBinding.instance.addPostFrameCallback] helps to execute
    //the code after the UI has been fully rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Fetch FormData
      formProvider.fetchForm();
    });
  }

//This function shows a dialog with form data
  void handleSubmit(FormProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return SubmitAlertDialog(
          provider: provider,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Selector to Listen for [API Response] Changes
        title: Selector<FormProvider, ApiResponse<DynamicForm>?>(
          // rebuilds as it only listens to [appResponse] in [FormProvider]
          selector: (p0, p1) => p1.appResponse,
          builder: (context, value, child) {
            switch (value?.status) {
              case Status.loading:
                // Show [Skelton Loader] While [Loading] State while ApiFetching
                return const Skeletonizer(child: Text('Dynamic Form'));
              case Status.error:
                // Display [Error Message] While Error Happens while ApiFetching
                return Text(value!.message.toString());
              case Status.completed:
                // Show The [Form Title] after sucessfully completing ApiFetching
                return Text(value?.data?.formTitle ?? 'Dynamic Form');
              default:
                return const SizedBox();
            }
          },
        ),
      ),
      body: Consumer<FormProvider>(
        builder: (context, provider, child) {
          final value = provider.appResponse;
          switch (value?.status) {
            // Show [SkeltonLoader] While Fetching Data
            case Status.loading:
              return const FormSkeleton();

            /// **Show [Error Message] While Fetching Data**
            case Status.error:
              return Text(value!.message.toString());

            case Status.completed:
              //Managing empty form case
              if (value == null || value.data == null) {
                return const Center(
                    child: Center(
                  child: Text("No form data available"),
                ));
              } else {
                //Showing Dynamic Form
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //Dynamicaly Generating Form Fields from List<FormField> we
                        //get from API Using [DynamicFormFieldWidget] base on its [Type]
                        // and adding it to column using [...] spread operator

                        ...value.data!.fields.map(
                          (field) => Row(
                            children: [
                              Text(field.index.toString()),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DynamicFormFieldWidget(
                                  field: field,
                                  formProvider: formProvider,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // validate Form Before Submitting
                            if (_formKey.currentState!.validate()) {
                              handleSubmit(formProvider);
                            }
                          },
                          child: const Text("Submit"),
                        )
                      ],
                    ),
                  ),
                );
              }

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
