import '../../domain/entities/dynamic_form.dart';
import '../../domain/repo/form_repo.dart';
import '../datasource/dynamic_form_remote_datasource.dart';

// Implementation of the FormRepository
// Fetches [FormData] from a API via [FormRemoteDataSource]
class FormRepositoryImpl implements FormRepository {
  final FormRemoteDataSource remoteDataSource;

  FormRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DynamicForm> fetchForm() async {
    return await remoteDataSource.fetchDynamicForm();
  }
}
