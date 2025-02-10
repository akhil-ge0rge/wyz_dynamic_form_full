import 'form_field_model.dart';
import '../../domain/entities/dynamic_form.dart';

class DynamicFormModel extends DynamicForm {
  DynamicFormModel({
    required super.formTitle,
    required List<FormFieldModel> super.fields,
  });

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) {
    var fieldsJson = json['fields'] as List;
    List<FormFieldModel> fieldsList =
        fieldsJson.map((f) => FormFieldModel.fromJson(f)).toList();
    fieldsList.sort((a, b) => a.index.compareTo(b.index));
    return DynamicFormModel(
      formTitle: json['formTitle'],
      fields: fieldsList,
    );
  }
}
