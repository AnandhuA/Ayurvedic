import 'dart:developer';

import 'package:ayurvedic/models/selected_treatment.dart';
import 'package:ayurvedic/services/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:ayurvedic/core/utlis/error_helper.dart';
import 'package:ayurvedic/models/branch_model.dart';
import 'package:ayurvedic/models/treatment_model.dart';
import 'package:ayurvedic/services/branch_service.dart';
import 'package:ayurvedic/services/treatment_service.dart';

class RegistrationViewModel extends ChangeNotifier {
  final BranchService _branchService = BranchService();
  final TreatmentService _treatmentService = TreatmentService();
  final PatientService _patientService = PatientService();

  List<Branch> _branches = [];
  List<Treatment> _treatments = [];

  final List<SelectedTreatment> _selectedTreatments = [];

  List<SelectedTreatment> get selectedTreatments => _selectedTreatments;

  String? _selectedLocation;
  Branch? _selectedBranch;
  Treatment? _selectedTreatment;

  bool _isLoading = false;
  bool _isSubmitting = false;
  String? _error;

  // ================= GETTERS =================

  List<Branch> get branches => _branches;
  List<Treatment> get treatments => _treatments;

  String? get selectedLocation => _selectedLocation;
  Branch? get selectedBranch => _selectedBranch;
  Treatment? get selectedTreatment => _selectedTreatment;

  bool get isLoading => _isLoading;
  bool get isSubmiting => _isSubmitting;
  String? get error => _error;

  // ================= LOAD DATA =================

  Future<void> loadInitialData() async {
    log("work");
    try {
      _isLoading = true;
      notifyListeners();

      _branches = await _branchService.getBranches();
      _treatments = await _treatmentService.getTreatments();
      log("tratment $_treatments");
      _error = null;
    } catch (e) {
      _error = ErrorHelper.getErrorMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ================= SELECT =================

  void selectLocation(String? value) {
    _selectedLocation = value;
    notifyListeners();
  }

  void selectBranch(Branch? value) {
    _selectedBranch = value;
    notifyListeners();
  }

  void selectTreatment(Treatment? value) {
    _selectedTreatment = value;
    notifyListeners();
  }

  void addTreatment({
    required Treatment treatment,
    required int male,
    required int female,
  }) {
    _selectedTreatments.add(
      SelectedTreatment(
        treatment: treatment,
        maleCount: male,
        femaleCount: female,
      ),
    );

    notifyListeners();
  }

  void removeTreatment(int index) {
    _selectedTreatments.removeAt(index);
    notifyListeners();
  }

  Future<void> submitPatient({
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
  }) async {
    try {
      if (selectedBranch == null) {
        throw Exception("Please select branch");
      }

      if (selectedTreatments.isEmpty) {
        throw Exception("Please add at least one treatment");
      }

      _isSubmitting = true;
      notifyListeners();

      /// ================= FORMAT DATE CORRECTLY =================
      /// API expects: 01/02/2024-10:24 AM
      /// Make sure UI already sends in this format.
      /// If not, convert before sending.

      /// ================= BUILD IDS =================

      final treatmentIds = selectedTreatments
          .map((e) => e.treatment.id)
          .join(",");
      final maleIds = selectedTreatments.expand((e) {
  return List.generate(e.maleCount, (_) => e.treatment.id);
}).join(",");

final femaleIds = selectedTreatments.expand((e) {
  return List.generate(e.femaleCount, (_) => e.treatment.id);
}).join(",");

      /// ================= SAFE DEFAULTS =================

      final safeMaleIds = maleIds.isEmpty ? "0" : maleIds;
      final safeFemaleIds = femaleIds.isEmpty ? "0" : femaleIds;

      /// ================= DEBUG =================

      print("========== SUBMIT PATIENT ==========");
      print("name: $name");
      print("executive: $executive");
      print("payment: $payment");
      print("phone: $phone");
      print("address: $address");
      print("totalAmount: $totalAmount");
      print("discountAmount: $discountAmount");
      print("advanceAmount: $advanceAmount");
      print("balanceAmount: $balanceAmount");
      print("dateNdTime: $dateNdTime");
      print("branchId: ${selectedBranch!.id}");
      print("treatmentIds: $treatmentIds");
      print("maleIds: $safeMaleIds");
      print("femaleIds: $safeFemaleIds");
      print("=====================================");

      /// ================= API CALL =================

      await _patientService.registerPatient(
        name: name,
        executive: executive,
        payment: payment,
        phone: phone,
        address: address,
        totalAmount: totalAmount,
        discountAmount: discountAmount,
        advanceAmount: advanceAmount,
        balanceAmount: balanceAmount,
        dateNdTime: dateNdTime,
        maleIds: safeMaleIds,
        femaleIds: safeFemaleIds,
        branchId: selectedBranch?.id??0,
        treatmentIds: treatmentIds,
      );

      _error = null;
    } catch (e) {
      _error = ErrorHelper.getErrorMessage(e);
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
