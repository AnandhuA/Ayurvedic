import 'branch_model.dart';

class Treatment {
  final int id;
  final String name;
  final String duration;
  final int price;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Branch> branches;

  Treatment({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    required this.branches,
    this.createdAt,
    this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: int.tryParse(json['id'].toString()) ?? 0,

      name: json['name']?.toString() ?? "",

      duration: json['duration']?.toString() ?? "",

      price: int.tryParse(json['price'].toString()) ?? 0,

      isActive: json['is_active'] ?? false,

      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,

      branches: (json['branches'] as List? ?? [])
          .map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
