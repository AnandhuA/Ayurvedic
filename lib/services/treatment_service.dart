import 'package:ayurvedic/core/constants/api_urls.dart';
import 'package:ayurvedic/core/network/dio_client.dart';
import 'package:ayurvedic/models/treatment_list_response_model.dart';
import 'package:ayurvedic/models/treatment_model.dart';
import 'package:dio/dio.dart';

class TreatmentService {
  final Dio _dio = DioClient().dio;

  Future<List<Treatment>> getTreatments() async {
    final response = await _dio.get(ApiUrls.treatmentList);
    final data = response.data;
    final model = TreatmentListResponseModel.fromJson(data);
    if (data["status"] == true) {
      return model.treatments;
    } else {
      throw Exception(data["message"]);
    }
  }
}
