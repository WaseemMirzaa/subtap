import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:subtap/core/extension/media_query_extension.dart';
import 'package:subtap/core/presentation/widgets/terms_and_policy_links.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Padding(
          padding:
              context.responsivePadding(horizontal: 15), // Responsive padding
          child: CustomText(
            text: 'Sign in Account',
            fontSize: context.responsiveFontSize(19),
            fontWeight: FontWeight.w300,
            color: AppColor.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.responsivePadding(horizontal: 7, vertical: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: context
                      .responsiveHeight(15)), // Pushes content down further
              const CustomTextField(
                hintText: 'Email/phone',
                fillColor: AppColor.mutedBlueShade,
                cursorColor: AppColor.white,
                borderColor: AppColor.mutedBlueShade,
                borderRadius: 18,
                textColor: AppColor.white,
                // contentPadding:
                //     context.responsivePadding(horizontal: 4, vertical: 2),
              ),
              SizedBox(height: context.responsiveHeight(2)),
              const CustomTextField(
                hintText: 'Password',
                fillColor: AppColor.mutedBlueShade,
                borderColor: AppColor.mutedBlueShade,
                textColor: AppColor.white,
                cursorColor: AppColor.white,
                borderRadius: 18,
                // contentPadding:
                //     context.responsivePadding(horizontal: 4, vertical: 2),
                obscureText: true,
                showPasswordToggle: true,
              ),
              SizedBox(height: context.responsiveHeight(1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Remember Me Checkbox
                  Row(
                    children: [
                      Checkbox(
                        fillColor: WidgetStateProperty.all(
                          AppColor.mutedBlueShade,
                        ),
                        side: const BorderSide(color: AppColor.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ), // Adjust for roundness (e.g., 4.0 for slight rounding)
                        ),
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                        activeColor: AppColor.backColor,
                        checkColor: AppColor.white,
                      ),
                      const CustomText(
                        text: 'Remember me',
                        color: AppColor.white,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  // Forgot Password
                  GestureDetector(
                    onTap: () {
                      // Add forgot password functionality
                    },
                    child: const CustomText(
                      text: 'Forgot Password?',
                      color: AppColor.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.responsiveHeight(3)),
              const CustomButton(
                // onTap: () => {Get.toNamed(AppRoutes.mainPageWithNavBar)},
                text: 'Sign in',
                radius: 20,
                height: 55,
              ),
              SizedBox(height: context.responsiveHeight(4)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50, // length of left divider
                    child: Divider(
                      color: AppColor.mutedBlueShade,
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      text: 'Sign-in with Apple/Google',
                      color: AppColor.white,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50, // length of right divider
                    child: Divider(
                      color: AppColor.mutedBlueShade,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.responsiveHeight(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 155, // adjust width as needed
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
                    width: 155, // adjust width as needed
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
              SizedBox(height: context.responsiveHeight(4)),
              const TermsAndPolicyLinks(),
              SizedBox(height: context.responsiveHeight(2)),
            ],
          ),
        ),
      ),
    );
  }
}
