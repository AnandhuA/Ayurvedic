import 'dart:developer';

import 'package:ayurvedic/models/patient_list_response_model.dart';
import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../core/constants/api_urls.dart';

class PatientService {
  final Dio _dio = DioClient().dio;

  Future<PatientListResponseModel> getPatients() async {
    final response = await _dio.get(ApiUrls.patientList);

    final data = response.data;
    if (data["status"] == true) {
      return PatientListResponseModel.fromJson(data);
    } else {
      throw Exception(data["message"] ?? "Failed to load patients");
    }
  }

  Future<void> registerPatient({
    required String name,
    required String executive,
    required String payment,
    required String phone,
    required String address,
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required double balanceAmount,
    required String dateNdTime,
    required String maleIds,
    required String femaleIds,
    required int branchId,
    required String treatmentIds,
  }) async {
    final formData = FormData.fromMap({
      "name": name,
      "excecutive": executive,
      "payment": payment,
      "phone": phone,
      "address": address,
      "total_amount": totalAmount,
      "discount_amount": discountAmount,
      "advance_amount": advanceAmount,
      "balance_amount": balanceAmount,
      "date_nd_time": dateNdTime,
      "id": "",
      "male": maleIds,
      "female": femaleIds,
      "branch": branchId,
      "treatments": treatmentIds,
    });

    try {
      final response = await _dio.post(ApiUrls.patientUpdate, data: formData);
      log("$response");
      final data = response.data;
    } catch (e) {
      log("$e");
    }

    // if (data["status"] != true) {
    //   throw Exception(data["message"] ?? "Registration failed");
    // }
  }
}
