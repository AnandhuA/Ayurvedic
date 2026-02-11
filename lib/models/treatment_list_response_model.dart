import 'package:ayurvedic/models/treatment_model.dart';

class TreatmentListResponseModel {
  final bool status;
  final String message;
  final List<Treatment> treatments;

  TreatmentListResponseModel({
    required this.status,
    required this.message,
    required this.treatments,
  });

  factory TreatmentListResponseModel.fromJson(Map<String, dynamic> json) {
    return TreatmentListResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      treatments: (json['treatments'] as List? ?? [])
          .map((e) => Treatment.fromJson(e))
          .toList(),
    );
  }
}
