import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:subtap/core/config/config.dart';
import 'package:subtap/core/extension/media_query_extension.dart';
import 'package:subtap/core/presentation/widgets/terms_and_policy_links.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Create Your Account',
          style: TextStyle(
              color: AppColor.backColor,
              fontSize: 18,
              fontFamily: 'HelveticaNeueMedium'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.responsiveHeight(10)),
              const CustomTextField(
                hintText: 'Email address',
                fillColor: AppColor.white,
                borderColor: AppColor.white,
                borderRadius: 18,
                textColor: AppColor.mediumGray,
                hintTextColor: AppColor.mediumGray,
                // contentPadding:
                //     context.responsivePadding(horizontal: 4, vertical: 2),
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                hintText: 'Password',
                hintTextColor: AppColor.mediumGray,
                fillColor: AppColor.white,
                borderColor: AppColor.white,
                textColor: AppColor.mediumGray,
                passwordToggleIconColor: AppColor.mediumGray,
                borderRadius: 18,
                // contentPadding:
                //     context.responsivePadding(horizontal: 4, vertical: 2),
                obscureText: true,
                showPasswordToggle: true,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                hintText: 'Confirm Password',
                hintTextColor: AppColor.mediumGray,
                fillColor: AppColor.white,
                borderColor: AppColor.white,
                textColor: AppColor.mediumGray,
                passwordToggleIconColor: AppColor.mediumGray,
                borderRadius: 18,
                // contentPadding:
                //     context.responsivePadding(horizontal: 4, vertical: 2),
                obscureText: true,
                showPasswordToggle: true,
              ),
              const SizedBox(height: 24),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.verifyEmail);
                },
                text: 'Sign Up',
                radius: 20,
                height: 55,
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50, // length of left divider
                    child: Divider(
                      color: AppColor.mutedGray,
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      text: 'Sign in with Apple or Google',
                      color: AppColor.grayShade,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50, // length of right divider
                    child: Divider(
                      color: AppColor.mutedGray,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.4, // adjust width as needed
                    child: CustomButton(
                      text: 'Apple',
                      icon: SvgPicture.asset(
                        Assets.svgsApple,
                        height: 20,
                      ),
                      enableIcon: true,
                      color: Colors.white,
                      textColor: AppColor.grayShade,
                      onTap: () {},
                      radius: 18,
                      height: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: context.screenWidth * 0.4, // adjust width as needed
                    child: CustomButton(
                      text: 'Google',
                      icon: SvgPicture.asset(
                        Assets.svgsGoogle,
                        height: 20,
                      ),
                      enableIcon: true,
                      color: Colors.white,
                      textColor: AppColor.grayShade,
                      onTap: () {},
                      radius: 18,
                      height: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const TermsAndPolicyLinks(textColor: Color(0xFF1A1A1A)),
            ],
          ),
        ),
      ),
    );
  }
}
