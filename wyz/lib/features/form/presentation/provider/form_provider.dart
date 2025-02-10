import 'package:flutter/material.dart';
import 'package:wyz/core/response/app_response.dart';
import '../../../../core/mixins/app_state.dart';
import '../../domain/entities/dynamic_form.dart';
import '../../domain/usecase/get_form.dart';

// [FormProvider] manage form data and state
// fetch dynamic form using [GetFormUseCase]
// store user input in [Map] in format of id and value
//
class FormProvider extends ChangeNotifier
    with AppStateHandleMixin<DynamicForm> {
  // [UseCase] to fetch form data
  final GetFormUseCase getDynamicFormUseCase;
  //[Map] to store user input as key - value pair
  // key - id | value - userInput
  Map<int, dynamic> formValues = {};

  FormProvider({required this.getDynamicFormUseCase});

// Fetch Dynamic Form from API
// Updates state using [setAppResponse] from [AppStateHandleMixin]
// Handles loading, success, and error states
  Future<void> fetchForm() async {
    //setLoading State
    setAppResponse = ApiResponse.loading();
    try {
      //fetching data from api using [UseCase]
      final result = await getDynamicFormUseCase();
      //set Sucess State
      setAppResponse = ApiResponse.completed(result);
    } catch (e) {
      //set Error State
      setAppResponse = ApiResponse.error(e.toString());
    }
  }

  // Stores the value of a form field in [formValues]
  ///Calls `notifyListeners()` to update the UI
  void updateFieldValue(int fieldId, dynamic value) {
    formValues[fieldId] = value;
    notifyListeners();
  }
}
