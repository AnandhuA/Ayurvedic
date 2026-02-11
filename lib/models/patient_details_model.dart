class PatientDetails {
  final int id;
  final String male;
  final String female;
  final int patient;
  final int treatment;
  final String treatmentName;

  PatientDetails({
    required this.id,
    required this.male,
    required this.female,
    required this.patient,
    required this.treatment,
    required this.treatmentName,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      id: json['id'] ?? 0,
      male: json['male'] ?? '',
      female: json['female'] ?? '',
      patient: json['patient'] ?? 0,
      treatment: json['treatment'] ?? 0,
      treatmentName: json['treatment_name'] ?? '',
    );
  }
}
