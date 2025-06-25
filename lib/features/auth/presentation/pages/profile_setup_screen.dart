import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:subtap/controller/navigation_controller.dart';
import 'package:subtap/core/config/config.dart';
import 'package:subtap/core/extension/media_query_extension.dart';
import 'package:subtap/core/presentation/widgets/terms_and_policy_links.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/theme/app_color.dart';

class ProfileSetupScreen extends StatelessWidget {
  final String? role;

  const ProfileSetupScreen({super.key, this.role});

  @override
  Widget build(BuildContext context) {
    final isSubcontractor = role == 'Subcontractor';

    return Scaffold(
      backgroundColor: AppColor.lightGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.backColor),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
            text: 'Profile Setup', color: AppColor.backColor, fontSize: 18),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: 'Full Name',
                  hintTextColor: AppColor.mediumGray,
                  fillColor: AppColor.white,
                  borderColor: AppColor.white,
                  borderRadius: 18,
                  textColor: AppColor.mediumGray,
                  contentPadding:
                      context.responsivePadding(horizontal: 4, vertical: 2),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Company Name',
                  hintTextColor: AppColor.mediumGray,
                  fillColor: AppColor.white,
                  borderColor: AppColor.white,
                  borderRadius: 18,
                  textColor: AppColor.mediumGray,
                  contentPadding:
                      context.responsivePadding(horizontal: 4, vertical: 2),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Phone Number',
                  hintTextColor: AppColor.mediumGray,
                  fillColor: AppColor.white,
                  borderColor: AppColor.white,
                  borderRadius: 18,
                  textColor: AppColor.mediumGray,
                  keyboardType: TextInputType.phone,
                  contentPadding:
                      context.responsivePadding(horizontal: 4, vertical: 2),
                ),
                if (isSubcontractor) ...[
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Referral Code(Optional)',
                    hintTextColor: AppColor.mediumGray,
                    fillColor: AppColor.white,
                    borderColor: AppColor.white,
                    borderRadius: 18,
                    textColor: AppColor.mediumGray,
                    contentPadding:
                        context.responsivePadding(horizontal: 4, vertical: 2),
                  ),
                  const SizedBox(height: 16),
                  const CustomButton(
                    radius: 15,
                    height: 50,
                    gradient: AppColor.buttonGradient,
                    text: 'Upload License (Optional,PDF/Image Upload)',
                    fontFamily: 'HelveticaNeueLightItalic',
                    fontSize: 14,
                    textColor: AppColor.black,
                  ),
                  const SizedBox(height: 16),
                  const CustomButton(
                    radius: 15,
                    height: 50,
                    gradient: AppColor.buttonGradient,
                    text: 'Upload Insurance (optional)',
                    fontFamily: 'HelveticaNeueLightItalic',
                    fontSize: 14,
                    textColor: AppColor.black,
                  ),
                ],
                const SizedBox(height: 32),
                CustomButton(
                  onTap: () {
                    // Set user type based on role
                    final navigationController =
                        Get.find<NavigationController>();
                    navigationController.setUserType(isSubcontractor);

                    // Navigate to main page
                    Get.offAllNamed(AppRoutes.mainPageWithNavBar);
                  },
                  text: 'Setup',
                  radius: 20,
                  height: 55,
                ),
                const SizedBox(height: 32),
                const TermsAndPolicyLinks(textColor: Color(0xFF1A1A1A)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
