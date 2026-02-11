
import 'package:ayurvedic/core/constants/api_urls.dart';
import 'package:ayurvedic/core/network/dio_client.dart';
import 'package:ayurvedic/models/branch_list_response_model.dart';
import 'package:ayurvedic/models/branch_model.dart';
import 'package:dio/dio.dart';

class BranchService {
  final Dio _dio = DioClient().dio;

  Future<List<Branch>> getBranches() async {
    final response = await _dio.get(ApiUrls.branchList);

    final data = response.data;
     final model = BranchListResponseModel.fromJson(data);
    if (data["status"] == true) {
         return model.branches;
    } else {
      throw Exception(data["message"]);
    }
  }
}
