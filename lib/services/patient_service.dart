
import 'package:ayurvedic/models/patient_list_response_model.dart';
import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../core/constants/api_urls.dart';

class PatientService {
  final Dio _dio = DioClient().dio;

   Future<PatientListResponseModel>  getPatients() async {
    final response = await _dio.get(ApiUrls.patientList);

    final data = response.data;
    if (data["status"] == true) {
          return PatientListResponseModel.fromJson(data);
    } else {
      throw Exception(data["message"] ?? "Failed to load patients");
    }
  }
}
