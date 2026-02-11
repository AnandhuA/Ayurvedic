import 'dart:developer';

import 'package:ayurvedic/core/utlis/error_helper.dart';
import 'package:ayurvedic/services/token_service.dart';
import 'package:dio/dio.dart';
import '../constants/api_urls.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {"Accept": "application/json"},
      ),
    );

    _addInterceptors();
  }

  void _addInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenService.getToken();

          if (token != null &&
              token.isNotEmpty &&
              options.path != ApiUrls.login) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onError: (error, handler) {
          final message = ErrorHelper.getErrorMessage(error);

          log("Dio Error: $message");

          return handler.reject(error);
        },
      ),
    );
  }
}
