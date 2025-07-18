import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/theme/app_color.dart';
import '../../../../controller/subcontractor_job_controller.dart';
import '../../../../core/shared_widgets/custom_text.dart';

import 'package:gap/gap.dart';

class ScopeSectionWidget extends StatelessWidget {
  const ScopeSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubcontractorJobController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              text: 'Scope',
              fontSize: screenWidth > 600 ? 18 : 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _showTooltip(
                  context, 'Describe the work to be completed in detail'),
              child: const Icon(
                Icons.help_outline,
                size: 16,
                color: AppColor.midGray,
              ),
            ),
          ],
        ),
        const Gap(5),
        Obx(() => CustomTextField(
              fontStyle: FontStyle.normal,
              fillColor: AppColor.white,
              controller: controller.descriptionController,
              borderColor: AppColor.white,
              hintText: 'Install framing for 2 interior walls',
              hintTextColor: AppColor.darkGrayShade,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              height: screenHeight * 0.13,
              contentPadding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01,
                horizontal: screenWidth * 0.04,
              ),
              readOnly: controller.makeCounterOffer.value,
            )),
      ],
    );
  }

  void _showTooltip(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColor.black.withOpacity(0.8),
      ),
    );
  }
}
