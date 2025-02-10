import '../entities/dynamic_form.dart';
import '../repo/form_repo.dart';

//Fetches form data from the repository
class GetFormUseCase {
  final FormRepository repository;

  GetFormUseCase(this.repository);

  Future<DynamicForm> call() async {
    return await repository.fetchForm();
  }
}
