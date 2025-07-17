part of 'widgets.dart';

class ExtrasSubmitButtons extends StatelessWidget {
  const ExtrasSubmitButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExtrasController>();

    return Column(
      children: [
        // Submit button
        Obx(() => CustomButton(
          text: 'Review Request',
          isLoading: controller.isSubmitting.value,
          loadingColor: Colors.white,
          onTap: controller.isFormValid && !controller.isSubmitting.value
              ? controller.showReviewDialog
              : null,
          color: controller.isFormValid
              ? AppColor.mutedGold
              : Colors.grey,
          textColor: Colors.white,
          fontWeight: FontWeight.w500,
          radius: 12,
        )),
        
        const SizedBox(height: 12),
        
        // Cancel button
        CustomButton(
          text: 'Cancel',
          onTap: () => Navigator.pop(context),
          color: AppColor.white.withOpacity(0.1),
          textColor: AppColor.white,
          fontWeight: FontWeight.w400,
          radius: 12,
        ),
      ],
    );
  }
}