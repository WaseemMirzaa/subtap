import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:subtap/core/config/config.dart';
import 'package:subtap/core/presentation/widgets/terms_and_policy_links.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  Assets.imagesLogo,
                  width: 275,
                  height: 275,
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  CustomButton(
                    onTap: () => {Get.toNamed(AppRoutes.login)},
                    text: 'Login',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    radius: 20,
                    height: 55,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    onTap: () => {Get.toNamed(AppRoutes.register)},
                    text: 'Create New Account',
                    fontWeight: FontWeight.w400,
                    textColor: AppColor.black,
                    color: AppColor.white,
                    radius: 20,
                    height: 55,
                  ),
                  const SizedBox(height: 32),
                  const TermsAndPolicyLinks(),
                  const SizedBox(height: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
