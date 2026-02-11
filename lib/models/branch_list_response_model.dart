import 'branch_model.dart';

class BranchListResponseModel {
  final bool status;
  final String message;
  final List<Branch> branches;

  BranchListResponseModel({
    required this.status,
    required this.message,
    required this.branches,
  });

  factory BranchListResponseModel.fromJson(Map<String, dynamic> json) {
    return BranchListResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      branches: (json['branches'] as List? ?? [])
          .map((e) => Branch.fromJson(e))
          .toList(),
    );
  }
}
