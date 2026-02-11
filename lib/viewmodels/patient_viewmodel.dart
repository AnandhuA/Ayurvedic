import 'package:ayurvedic/core/utlis/date_helper.dart';
import 'package:ayurvedic/models/patient_list_response_model.dart';
import 'package:ayurvedic/models/patient_model.dart';
import 'package:flutter/material.dart';
import '../services/patient_service.dart';
import '../core/utlis/error_helper.dart';

class PatientViewModel extends ChangeNotifier {
  final PatientService _service = PatientService();

  List<Patient> _allPatients = [];
  List<Patient> _patients = [];

  bool _isLoading = false;
  String? _error;
  String _searchQuery = "";
  String _currentSort = "All";

  List<Patient> get patients => _patients;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ================= FETCH =================
  Future<void> fetchPatients() async {
    try {
      _isLoading = true;
      notifyListeners();

      final PatientListResponseModel patientListResponseModel = await _service
          .getPatients();
      _allPatients = patientListResponseModel.patients;
      _patients = List.from(_allPatients);
      _error = null;
    } catch (e) {
      _error = ErrorHelper.getErrorMessage(e);
      _patients = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ================= SEARCH =================

  void search(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  // ================= SORT =================

  void sortBy(String type) {
    _currentSort = type;
    _applyFilters();
    notifyListeners();
  }

  // ================= APPLY FILTERS =================

  void _applyFilters() {
    List<Patient> temp = List.from(_allPatients);

    if (_searchQuery.isNotEmpty) {
      temp = temp.where((p) {
        return (p.name ).toLowerCase().contains(_searchQuery) ||
            (p.phone).toLowerCase().contains(_searchQuery);
      }).toList();
    }

    switch (_currentSort) {
      case "Today":
        temp = temp.where((p) => DateHelper.isToday(p.updatedAt)).toList();
        break;

      case "Yesterday":
        temp = temp.where((p) => DateHelper.isYesterday(p.updatedAt)).toList();
        break;

      case "This Week":
        temp = temp.where((p) => DateHelper.isThisWeek(p.updatedAt)).toList();
        break;

      case "Oldest":
        temp.sort(
          (a, b) => DateTime.parse(
            a.updatedAt,
          ).compareTo(DateTime.parse(b.updatedAt)),
        );
        break;

      case "All":
      default:
        break;
    }

    _patients = temp;
  }
}
