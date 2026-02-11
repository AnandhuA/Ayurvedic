import 'package:ayurvedic/viewmodels/auth_viewmodel.dart';
import 'package:ayurvedic/viewmodels/patient_viewmodel.dart';
import 'package:ayurvedic/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => PatientViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: const SplashScreen(),
      ),
    );
  }
}
