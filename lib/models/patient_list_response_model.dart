import 'package:ayurvedic/models/patient_model.dart';

class PatientListResponseModel {
  final bool status;
  final String message;
  final List<Patient> patients;

  PatientListResponseModel({
    required this.status,
    required this.message,
    required this.patients,
  });

  factory PatientListResponseModel.fromJson(Map<String, dynamic> json) {
    return PatientListResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      patients: (json['patient'] as List<dynamic>?)
              ?.map((e) => Patient.fromJson(e))
              .toList() ??
          [],
    );
  }
}


