import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/theme/app_color.dart';
import '../../../../controller/subcontractor_job_controller.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text.dart';

class PreviewModalWidget extends StatelessWidget {
  const PreviewModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubcontractorJobController>();

    return Obx(() => controller.showPreview.value
        ? Container(
            color: Colors.black54,
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Proposal Preview',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 16),
                    CustomText(
                      text:
                          'You are submitting a proposal for \$${controller.itemizedTotal.toStringAsFixed(2)} to Jason Rao',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text: 'Scope: ${controller.descriptionController.text}',
                      fontSize: 14,
                      color: AppColor.midGray,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text:
                          'Timeline: ${controller.startDateController.text} - ${controller.endDateController.text}',
                      fontSize: 14,
                      color: AppColor.midGray,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Edit',
                            onTap: () => controller.showPreview.value = false,
                            color: AppColor.white,
                            textColor: AppColor.black,
                            fontWeight: FontWeight.w400,
                            radius: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            text: 'Submit',
                            onTap: () {
                              controller.showPreview.value = false;
                              // Handle submission
                              Get.back();
                            },
                            color: AppColor.mutedGold,
                            textColor: Colors.white,
                            fontWeight: FontWeight.w400,
                            radius: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink());
  }
}
