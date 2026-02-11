import 'dart:ui';
import 'package:ayurvedic/core/constants/colors.dart';
import 'package:ayurvedic/core/constants/sizes.dart';
import 'package:ayurvedic/core/utlis/validation_helper.dart';
import 'package:ayurvedic/viewmodels/auth_viewmodel.dart';
import 'package:ayurvedic/views/home/home_screen.dart';
import 'package:ayurvedic/views/widgets/custom_buttom.dart';
import 'package:ayurvedic/views/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:ayurvedic/core/constants/app_assets.dart';
import 'package:ayurvedic/core/utlis/media_query_helper.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = .new();
  final TextEditingController _passwordController = .new();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MQ.width(context),
                  height: MQ.h(context, 25),
                  child: Stack(
                    // fit: StackFit.expand,
                    children: [
                      Image.asset(AppAssets.backgroundImage, fit: BoxFit.cover),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: MQ.w(context, 20),
                          height: MQ.h(context, 20),
                          child: Image.asset(AppAssets.appLogo, scale: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.h12(),
                Padding(
                  padding: AppPadding.p18,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Login Or Register To Book Your Appointments",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        AppSpacing.h24(),
                        CustomTextFeild(
                          controller: _emailController,
                          titleText: "Email",
                          hitText: "Enter Your Email",
                          validator: ValidatorHelper.name,
                          // validator: ValidatorHelper.email,
                        ),
                        AppSpacing.h12(),
                        CustomTextFeild(
                          controller: _passwordController,
                          titleText: "Password",
                          hitText: "Enter Password",
                          validator: ValidatorHelper.password,
                          isPassword: true,
                        ),
                        AppSpacing.hMq(context, 10),
                        Consumer<AuthViewModel>(
                          builder: (context, auth, child) {
                            return CustomButtom(
                              title: "Login",
                              onTap: _handleLogin,
                              bgColor: AppColors.primaryDark,
                              textColor: AppColors.textWhite,
                              isLoading: auth.isLoading,
                            );
                          },
                        ),
                        AppSpacing.hMq(context, 10),

                        Text(
                          "By creating or logging into an account you are agreeing with our Terms and Conditions and Privacy Policy.",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final authVM = context.read<AuthViewModel>();

    final success = await authVM.login(
      username: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authVM.errorMessage ?? "Login failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
