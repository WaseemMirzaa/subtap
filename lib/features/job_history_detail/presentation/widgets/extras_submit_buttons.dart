part of 'widgets.dart';

class ExtrasSubmitButtons extends StatelessWidget {
  const ExtrasSubmitButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExtrasController>();

    return Column(
      children: [
        // Submit button
        Obx(() {
          final isFormValid = controller.isFormValid;
          final isSubmitting = controller.isSubmitting.value;

          return CustomButton(
            text: 'Review Request',
            isLoading: isSubmitting,
            loadingColor: Colors.white,
            onTap: isFormValid && !isSubmitting
                ? () => Future.microtask(() => controller.showReviewDialog())
                : null,
            color: isFormValid ? AppColor.mutedGold : Colors.grey,
            textColor: Colors.white,
            fontWeight: FontWeight.w500,
            radius: 12,
          );
        }),

        const SizedBox(height: 12),

        // Cancel button
        CustomButton(
          text: 'Cancel',
          onTap: () => Get.back(),
          color: AppColor.white.withOpacity(0.1),
          textColor: AppColor.white,
          fontWeight: FontWeight.w400,
          radius: 12,
        ),
      ],
    );
  }
}
