import 'package:ayurvedic/core/constants/colors.dart';
import 'package:ayurvedic/core/constants/sizes.dart';
import 'package:ayurvedic/core/utlis/media_query_helper.dart';
import 'package:ayurvedic/viewmodels/patient_viewmodel.dart';
import 'package:ayurvedic/viewmodels/registration_viewmodel.dart';
import 'package:ayurvedic/views/home/details_screen.dart';
import 'package:ayurvedic/views/home/regisration_screen.dart';
import 'package:ayurvedic/views/widgets/custom_buttom.dart';
import 'package:ayurvedic/views/widgets/custom_card_widget.dart';
import 'package:ayurvedic/views/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = .new();
  final List<String> _sortOptions = [
    "All",
    "Today",
    "Yesterday",
    "This Week",
    "Oldest",
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PatientViewModel>().fetchPatients());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          preferredSize: Size(MQ.width(context), MQ.h(context, 10)),
          child: Padding(
            padding: AppPadding.p16,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      context.read<PatientViewModel>().search(value);
                    },
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.br12(),
                      ),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search for treatments",
                    ),
                  ),
                ),
                AppSpacing.w12(),
                CustomButtom(
                  title: "Search",
                  onTap: () {
                    if (_searchController.text.isNotEmpty) {
                      context.read<PatientViewModel>().search(
                        _searchController.text,
                      );
                    }
                  },
                  width: 25,
                  height: 5,
                  bgColor: AppColors.primaryDark,
                  textColor: AppColors.textWhite,
                ),
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Consumer<PatientViewModel>(
          builder: (context, patientProvider, _) {
            if (patientProvider.isLoading) {
              return Center(
                child: EmptyScreen(
                  text1: "Patient",
                  size1: 12,
                  text2: "List",
                  size2: 22,
                  text3: "Loading",
                  size3: 20,
                  isLoading: true,
                ),
              );
            }
            if (patientProvider.error != null) {
              return Center(
                child: EmptyScreen(
                  text1: "Opps",
                  size1: 15,
                  text2: "Somthing Wrong",
                  size2: 20,
                  text3: patientProvider.error ?? "error",
                  size3: 20,
                ),
              );
            }

            return Column(
              children: [
                _headerSection(context, patientProvider),
                Divider(),
                AppSpacing.h12(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await patientProvider.fetchPatients();
                    },
                    child: patientProvider.patients.isEmpty
                        ? Center(
                            child: EmptyScreen(
                              text1: "Show",
                              size1: 15,
                              text2: "Nothing",
                              size2: 20,
                              text3: "Empty",
                              size3: 20,
                              // isLoading: true,
                            ),
                          )
                        : Padding(
                            padding: AppPadding.h16,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  AppSpacing.h16(),
                              itemCount: patientProvider.patients.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        patient:
                                            patientProvider.patients[index],
                                      ),
                                    ),
                                  );
                                },
                                child: CustomCardWidget(
                                  patient: patientProvider.patients[index],
                                  index: index,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: AppPadding.h16,
                  child: CustomButtom(
                    title: "Register Now",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) =>
                                RegistrationViewModel()..loadInitialData(),
                            child: const RegisrationScreen(),
                          ),
                        ),
                      );
                    },
                    bgColor: AppColors.primaryDark,
                    textColor: AppColors.textWhite,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding _headerSection(
    BuildContext context,
    PatientViewModel patientProvider,
  ) {
    return Padding(
      padding: AppPadding.p16,
      child: Row(
        children: [
          Text(
            "Sort by:",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Spacer(),
          SizedBox(
            width: MQ.w(context, 45),
            child: DropdownButtonFormField<String>(
              hint: Text("Date"),
              // initialValue: _selectedSort,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(borderRadius: AppRadius.brFull()),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
              ),
              items: _sortOptions
                  .map(
                    (option) => DropdownMenuItem(
                      value: option,
                      child: Text(
                        option,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  patientProvider.sortBy(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
