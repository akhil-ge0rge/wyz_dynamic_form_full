import 'package:wyz/features/form/domain/entities/form_fields.dart';

class DynamicForm {
  final String formTitle;
  final List<FormField> fields;

  DynamicForm({
    required this.formTitle,
    required this.fields,
  });
}
