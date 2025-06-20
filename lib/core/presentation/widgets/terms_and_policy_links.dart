import 'package:flutter/material.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';

class TermsAndPolicyLinks extends StatelessWidget {
  const TermsAndPolicyLinks({super.key, this.textColor});
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  text: 'By continuing, you agree to our',
                  color: textColor ?? AppColor.white,
                  fontSize: 12),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 0,
            children: [
              InkWell(
                onTap: null,
                child: CustomText(
                  text: 'Terms of Service',
                  color: textColor ?? Colors.white,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: textColor ?? Colors.white,
                ),
              ),
              CustomText(text: ' - ', color: textColor ?? Colors.white70),
              InkWell(
                onTap: null,
                child: CustomText(
                  text: 'Privacy Policy',
                  color: textColor ?? Colors.white,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: textColor ?? Colors.white,
                ),
              ),
              CustomText(text: ' - ', color: textColor ?? Colors.white70),
              InkWell(
                onTap: null,
                child: CustomText(
                  text: 'Content Policy',
                  color: textColor ?? Colors.white,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: textColor ?? Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
