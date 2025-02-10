import 'package:get_it/get_it.dart';
import 'package:wyz/features/form/data/datasource/dynamic_form_remote_datasource.dart';
import 'package:wyz/features/form/data/repo/form_repo_impl.dart';
import 'package:wyz/features/form/domain/repo/form_repo.dart';
import 'package:wyz/features/form/domain/usecase/get_form.dart';
import 'package:http/http.dart' as http;
import '../../features/form/presentation/provider/form_provider.dart';

final di = GetIt.instance;

Future<void> init() async {
  await _initForm();
}

//Register all dependencies required for Form
Future<void> _initForm() async {
  // [registerFactory] -> A new instance of `FormProvider` is created every time it is requested
  // [registerLazySingleton] -> Same instance is used throughout the app
  di
    ..registerFactory(() => FormProvider(getDynamicFormUseCase: di()))
    ..registerLazySingleton(() => GetFormUseCase(di()))
    ..registerLazySingleton<FormRepository>(
        () => FormRepositoryImpl(remoteDataSource: di()))
    ..registerLazySingleton<FormRemoteDataSource>(
        () => FormRemoteDataSourceImpl(client: di()))
    ..registerLazySingleton(
      () => http.Client(),
    );
}
