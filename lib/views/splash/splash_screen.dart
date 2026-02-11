import 'dart:ui';

import 'package:ayurvedic/core/constants/app_assets.dart';
import 'package:ayurvedic/core/constants/colors.dart';
import 'package:ayurvedic/core/utlis/media_query_helper.dart';
import 'package:ayurvedic/services/token_service.dart';
import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await TokenService.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MQ.width(context),
        height: MQ.height(context),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.backgroundImage, fit: BoxFit.cover),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: AppColors.primaryDark.withValues(alpha: 0.2),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: MQ.w(context, 25),
                height: MQ.h(context, 25),
                child: Image.asset(AppAssets.appLogo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
