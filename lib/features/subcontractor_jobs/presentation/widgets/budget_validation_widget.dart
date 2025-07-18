import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/subcontractor_job_controller.dart';
import '../../../../core/shared_widgets/custom_text.dart';

class BudgetValidationWidget extends StatelessWidget {
  const BudgetValidationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubcontractorJobController>();

    return Obx(() {
      if (controller.hasRemainingMismatch) {
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  text:
                      'Your line items do not match the total. Please adjust or confirm if intentional.',
                  fontSize: 12,
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
