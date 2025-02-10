import 'package:flutter/material.dart';

import '../response/app_response.dart';

mixin AppStateHandleMixin<T> on ChangeNotifier {
  ApiResponse<T>? _appResponse;

  set setAppResponse(ApiResponse<T>? appResponse) {
    _appResponse = appResponse;
    if (appResponse == null) return;
    notifyListeners();
  }

  ApiResponse<T>? get appResponse => _appResponse;
}
