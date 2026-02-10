import 'package:ayurvedic/services/token_service.dart';
import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../core/constants/api_urls.dart';

class AuthService {
  final Dio _dio = DioClient().dio;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiUrls.login,
      data: {"username": username, "password": password},
    );

    final token = response.data["token"];

    if (token != null) {
      await TokenService.saveToken(token);
    } else {
      throw Exception("Token not found");
    }
  }
}
