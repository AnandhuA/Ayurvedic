import 'package:ayurvedic/core/constants/app_assets.dart';
import 'package:ayurvedic/core/constants/colors.dart';
import 'package:ayurvedic/core/constants/sizes.dart';
import 'package:ayurvedic/core/utlis/date_helper.dart';
import 'package:ayurvedic/core/utlis/media_query_helper.dart';
import 'package:ayurvedic/views/widgets/lable_value_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ayurvedic/models/patient_model.dart';

class DetailsScreen extends StatelessWidget {
  final Patient patient;

  const DetailsScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Details"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.p16,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.br16()),
            child: Padding(
              padding: AppPadding.p20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //HEADER
                  _buildHeader(context),

                  AppSpacing.h24(),
                  const Divider(),

                  //PATIENT INFO
                  _buildPatientInfo(),

                  AppSpacing.h24(),

                  // TREATMENT TABLE
                  _buildTreatmentTable(),

                  AppSpacing.h24(),
                  const Divider(),

                  // TOTAL SECTION
                  _buildTotalSection(),

                  AppSpacing.h32(),

                  // FOOTER
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Thank you for choosing us",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AppSpacing.h12(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Your well-being is our commitment, and we're honored\nyou've entrusted us with your health journey",
                      maxLines: 3,
                      style: TextStyle(fontSize: 10, color: AppColors.textGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ================= HEADER =================

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        SizedBox(
          width: MQ.w(context, 10),
          height: MQ.h(context, 10),
          child: Image.asset(AppAssets.appLogo),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Amritha Ayurveda",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text("Kumarakom"),
            Text("${patient.branch?.gst}"),
          ],
        ),
      ],
    );
  }

  /// ================= PATIENT INFO =================

  Widget _buildPatientInfo() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const Text(
          "Patient Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
        AppSpacing.h16(),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelValueText(label: "Name", value: patient.name),
                LabelValueText(label: "Address", value: patient.address),
                LabelValueText(label: "Number", value: patient.phone),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelValueText(
                  label: "Booked On",
                  value: DateHelper.formatToDDMMYYYY(patient.createdAt),
                ),

                LabelValueText(
                  label: "Treatment Date",
                  value: DateHelper.formatToDDMMYYYY(patient.updatedAt),
                ),

                LabelValueText(
                  label: "Treatment Time :",
                  value: DateHelper.formatToDDMMYYYY(patient.updatedAt),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// ================= TREATMENT TABLE =================

  Widget _buildTreatmentTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            const Text(
              "Treatment",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            Text(
              "Price",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),

        const Divider(),
        ...patient.details.map(
          (treatment) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(treatment.treatmentName)),
                Text("₹${patient.totalAmount}"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// ================= TOTAL SECTION =================

  Widget _buildTotalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildAmountRow("Total Amount", patient.totalAmount),
        _buildAmountRow("Discount", patient.discountAmount),
        _buildAmountRow("Advance", patient.advanceAmount),
        const Divider(),
        _buildAmountRow("Balance", patient.balanceAmount, isBold: true),
      ],
    );
  }

  Widget _buildAmountRow(String title, int? amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title),
          const SizedBox(width: 20),
          Text(
            "₹${amount ?? 0}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
