import 'package:ayurvedic/core/constants/colors.dart';
import 'package:ayurvedic/core/constants/location_list.dart';
import 'package:ayurvedic/core/constants/sizes.dart';
import 'package:ayurvedic/core/utlis/media_query_helper.dart';
import 'package:ayurvedic/core/utlis/validation_helper.dart';
import 'package:ayurvedic/models/branch_model.dart';
import 'package:ayurvedic/models/treatment_model.dart';
import 'package:ayurvedic/viewmodels/registration_viewmodel.dart';
import 'package:ayurvedic/views/widgets/custom_buttom.dart';
import 'package:ayurvedic/views/widgets/custom_dropdown.dart';
import 'package:ayurvedic/views/widgets/custom_text_feild.dart';
import 'package:ayurvedic/views/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegisrationScreen extends StatefulWidget {
  const RegisrationScreen({super.key});

  @override
  State<RegisrationScreen> createState() => _RegisrationScreenState();
}

class _RegisrationScreenState extends State<RegisrationScreen> {
  final TextEditingController _nameController = .new();
  final TextEditingController _phoneController = .new();
  final TextEditingController _addressController = .new();
  final TextEditingController _totaAmountController = .new();
  final TextEditingController _discountAmountController = .new();
  final TextEditingController _advanceAmountController = .new();
  final TextEditingController _balanceAmountController = .new();
  final TextEditingController _dateController = .new();
  String? selectedLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge.count(
              count: 2,
              child: const Icon(Icons.notifications_none_outlined),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(MQ.width(context), MQ.h(context, 5)),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: AppPadding.only(left: 25),
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<RegistrationViewModel>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return Center(
                child: EmptyScreen(
                  text1: "Please",
                  size1: 12,
                  text2: "Wait",
                  size2: 22,
                  text3: "Loading",
                  size3: 20,
                  isLoading: true,
                ),
              );
            }
            if (provider.error != null) {
              return Center(
                child: EmptyScreen(
                  text1: "Opps",
                  size1: 12,
                  text2: "Somthing Wrong",
                  size2: 22,
                  text3: provider.error ?? "",
                  size3: 20,
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: AppPadding.p16,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      CustomTextFeild(
                        controller: _nameController,
                        titleText: "Name",
                        hitText: "Enter your Name",
                        validator: ValidatorHelper.name,
                      ),
                      AppSpacing.h32(),
                      CustomTextFeild(
                        controller: _phoneController,
                        titleText: "Whatsapp Number",
                        hitText: "Enter your Whatsapp number",
                        validator: ValidatorHelper.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      AppSpacing.h32(),
                      CustomTextFeild(
                        controller: _addressController,
                        titleText: "Address",
                        hitText: "Enter your full address",
                        validator: ValidatorHelper.isRequired,
                        keyboardType: TextInputType.text,
                      ),
                      AppSpacing.h32(),

                      CustomDropdown<String>(
                        title: "Location",
                        hint: "Choose your location",
                        value: provider.selectedLocation,
                        items: locations, // your static list
                        labelBuilder: (value) => value,
                        onChanged: provider.selectLocation,
                      ),

                      AppSpacing.h32(),

                      CustomDropdown<Branch>(
                        title: "Branch",
                        hint: "Select Branch",
                        value: provider.selectedBranch,
                        items: provider.branches,
                        labelBuilder: (branch) => branch.name,
                        onChanged: provider.selectBranch,
                      ),

                      AppSpacing.h32(),

                      Text(
                        "Treatments",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      AppSpacing.h16(),
                      if (provider.selectedTreatments.isNotEmpty)
                        Column(
                          children: List.generate(
                            provider.selectedTreatments.length,
                            (index) {
                              final item = provider.selectedTreatments[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.grey.withValues(alpha: 0.3),
                                  borderRadius: AppRadius.br12(),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${item.treatment.name} (${item.treatment.price})",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          AppSpacing.h12(),
                                          Row(
                                            mainAxisAlignment: .spaceAround,
                                            children: [
                                              Text("Male: ${item.maleCount}"),
                                              Text(
                                                "Female: ${item.femaleCount}",
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        provider.removeTreatment(index);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                      CustomButtom(
                        title: "+ Add Treatments",
                        onTap: () {
                          _showTreatmentBottomSheet(context, provider);
                        },
                        bgColor: AppColors.primaryLight,
                        textColor: AppColors.textBlack,
                      ),
                      AppSpacing.h32(),
                      CustomTextFeild(
                        controller: _totaAmountController,
                        titleText: "Total Amount",
                        hitText: "",
                        validator: ValidatorHelper.isRequired,
                        keyboardType: TextInputType.name,
                      ),
                      AppSpacing.h32(),
                      CustomTextFeild(
                        controller: _discountAmountController,
                        titleText: "Discount Amount",
                        hitText: "",
                        validator: ValidatorHelper.isRequired,
                        keyboardType: TextInputType.name,
                      ),

                      // add radio button
                      AppSpacing.h32(),
                      CustomTextFeild(
                        controller: _advanceAmountController,
                        titleText: "Advance Amount",
                        hitText: "",
                        validator: ValidatorHelper.isRequired,
                        keyboardType: TextInputType.name,
                      ),

                      AppSpacing.h32(),
                      CustomTextFeild(
                        controller: _balanceAmountController,
                        titleText: "Balance Amount",
                        hitText: "",
                        validator: ValidatorHelper.isRequired,
                        keyboardType: TextInputType.name,
                      ),

                      AppSpacing.h32(),
                      Text(
                        "Treatment Date",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      AppSpacing.h12(),
                      TextFormField(
                        controller: _dateController,

                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Select Date",
                          fillColor: AppColors.grey.withValues(alpha: 0.2),
                          border: OutlineInputBorder(
                            borderRadius: AppRadius.br12(),
                            borderSide: BorderSide(),
                          ),
                          suffixIcon: Icon(Icons.calendar_month),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2030),
                          );

                          if (pickedDate == null) return;

                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime == null) return;

                          final DateTime fullDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );

                          _dateController.text = DateFormat(
                            "dd/MM/yyyy-hh:mm a",
                          ).format(fullDateTime);
                        },
                        validator: ValidatorHelper.isRequired,
                      ),
                      AppSpacing.h32(),
                      CustomButtom(
                        title: "Save",
                        onTap: () => _onSave(provider),
                        bgColor: AppColors.primaryDark,
                        textColor: AppColors.textWhite,
                        isLoading: provider.isSubmiting,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onSave(RegistrationViewModel provider) async {
    if (!_formKey.currentState!.validate()) return;

    if (provider.selectedBranch == null) {
      _showMessage("Please select branch");
      return;
    }

    if (provider.selectedTreatments.isEmpty) {
      _showMessage("Please add at least one treatment");
      return;
    }

    await provider.submitPatient(
      name: _nameController.text.trim(),
      executive: "Admin", // change if dynamic
      payment: "Cash", // change if using radio
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      totalAmount: double.tryParse(_totaAmountController.text) ?? 0,
      discountAmount: double.tryParse(_discountAmountController.text) ?? 0,
      advanceAmount: double.tryParse(_advanceAmountController.text) ?? 0,
      balanceAmount: double.tryParse(_balanceAmountController.text) ?? 0,
      dateNdTime: _dateController.text,
    );

    if (provider.error == null) {
      _showSuccessDialog();
    } else {
      _showMessage(provider.error!);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Patient registered successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showTreatmentBottomSheet(
    BuildContext context,
    RegistrationViewModel provider,
  ) {
    int maleCount = 0;
    int femaleCount = 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: AppPadding.p12,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.h20(),
                  CustomDropdown<Treatment>(
                    title: "Choose Treatment",
                    hint: "Select Treatment",
                    value: provider.selectedTreatment,
                    items: provider.treatments,
                    labelBuilder: (treatment) =>
                        "${treatment.name} - ₹${treatment.price}",
                    onChanged: provider.selectTreatment,
                  ),
                  AppSpacing.h20(),

                  const Text(
                    "Add Patients",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),

                  AppSpacing.h20(),

                  /// Male Row
                  _counterRow(
                    label: "Male",
                    count: maleCount,
                    onAdd: () {
                      setState(() => maleCount++);
                    },
                    onRemove: () {
                      if (maleCount > 0) {
                        setState(() => maleCount--);
                      }
                    },
                  ),

                  AppSpacing.h16(),

                  /// Female Row
                  _counterRow(
                    label: "Female",
                    count: femaleCount,
                    onAdd: () {
                      setState(() => femaleCount++);
                    },
                    onRemove: () {
                      if (femaleCount > 0) {
                        setState(() => femaleCount--);
                      }
                    },
                  ),

                  AppSpacing.h20(),

                  /// Save Button
                  CustomButtom(
                    title: "Save",
                    onTap: () {
                      if (provider.selectedTreatment != null) {
                        provider.addTreatment(
                          treatment: provider.selectedTreatment!,
                          male: maleCount,
                          female: femaleCount,
                        );
                      }
                      Navigator.pop(context);
                    },
                    bgColor: AppColors.primaryDark,
                    textColor: AppColors.textWhite,
                  ),
                  AppSpacing.h12(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _counterRow({
    required String label,
    required int count,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Row(
      children: [
        /// Label Box
        Expanded(
          child: Container(
            padding: AppPadding.v12,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(label)),
          ),
        ),
        AppSpacing.w16(),

        /// Minus Button
        CircleAvatar(
          backgroundColor: AppColors.primaryDark,
          child: IconButton(
            icon: const Icon(Icons.remove, color: AppColors.white),
            onPressed: onRemove,
          ),
        ),

        AppSpacing.w12(),

        /// Count Box
        Container(
          width: 50,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: AppRadius.br12(),
          ),
          child: Text(count.toString(), style: const TextStyle(fontSize: 16)),
        ),
        AppSpacing.w12(),

        CircleAvatar(
          backgroundColor: AppColors.primaryDark,
          child: IconButton(
            icon: const Icon(Icons.add, color: AppColors.white),
            onPressed: onAdd,
          ),
        ),
      ],
    );
  }
}
