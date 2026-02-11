import 'package:ayurvedic/models/treatment_model.dart';

class SelectedTreatment {
  final Treatment treatment;
  final int maleCount;
  final int femaleCount;

  SelectedTreatment({
    required this.treatment,
    required this.maleCount,
    required this.femaleCount,
  });
}
