import '../entities/dynamic_form.dart';

//Abstract Repository for Forms
abstract class FormRepository {
  Future<DynamicForm> fetchForm();
}
