import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:wyz/features/form/data/model/dynamic_form_model.dart';

//Abstract class for fetching data from API
abstract class FormRemoteDataSource {
  Future<DynamicFormModel> fetchDynamicForm();
}

//Implementation of FormRemoteDataSource
/// - Uses [http.Client] for making network requests.
/// - Fetches JSON data and converts it into [DynamicFormModel].
class FormRemoteDataSourceImpl implements FormRemoteDataSource {
  final http.Client client;

  FormRemoteDataSourceImpl({required this.client});

  @override
  Future<DynamicFormModel> fetchDynamicForm() async {
    try {
      final response =
          await client.get(Uri.parse('http://localhost:3000/api/form'));
      if (response.statusCode == 200) {
        log(response.toString());
        final data = json.decode(response.body);
        return DynamicFormModel.fromJson(data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
