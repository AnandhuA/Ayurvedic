import 'package:ayurvedic/models/branch_model.dart';
import 'package:ayurvedic/models/patient_details_model.dart';

class Patient {
  final int id;
  final List<PatientDetails> details;
  final Branch? branch;
  final String user;
  final String payment;
  final String name;
  final String phone;
  final String address;
  final double? price;
  final int totalAmount;
  final int discountAmount;
  final int advanceAmount;
  final int balanceAmount;
  final String dateNdTime;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  Patient({
    required this.id,
    required this.details,
    this.branch,
    required this.user,
    required this.payment,
    required this.name,
    required this.phone,
    required this.address,
    this.price,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateNdTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      details: (json['patientdetails_set'] as List<dynamic>?)
              ?.map((e) => PatientDetails.fromJson(e))
              .toList() ??
          [],
      branch:
          json['branch'] != null ? Branch.fromJson(json['branch']) : null,
      user: json['user'] ?? '',
      payment: json['payment'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      totalAmount: json['total_amount'] ?? 0,
      discountAmount: json['discount_amount'] ?? 0,
      advanceAmount: json['advance_amount'] ?? 0,
      balanceAmount: json['balance_amount'] ?? 0,
      dateNdTime: json['date_nd_time'] ?? '',
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
