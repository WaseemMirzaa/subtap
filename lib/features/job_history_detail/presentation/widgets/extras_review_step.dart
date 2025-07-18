part of 'widgets.dart';

class ExtrasReviewStep extends StatelessWidget {
  const ExtrasReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExtrasController>();

    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.white.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              // Review header
              const Row(
                children: [
                  Icon(
                    Icons.preview,
                    color: AppColor.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  CustomText(
                    text: 'Review Your Request',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Review message
              Text(
                'You\'re about to request \$${controller.getTotalAmount().toStringAsFixed(2)} in extras. This will be sent to the property manager for approval.',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColor.white,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Action buttons
              Row(
                children: [
                  // Cancel button
                  Expanded(
                    child: CustomButton(
                      text: '❌ Cancel',
                      onTap: controller.hideReviewDialog,
                      color: Colors.red.withOpacity(0.2),
                      textColor: Colors.red,
                      fontWeight: FontWeight.w500,
                      radius: 8,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Confirm button
                  Expanded(
                    child: CustomButton(
                      text: '✅ Confirm',
                      isLoading: controller.isSubmitting.value,
                      loadingColor: Colors.white,
                      onTap: controller.isSubmitting.value
                          ? null
                          : controller.submitExtras,
                      color: Colors.green,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w500,
                      radius: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
