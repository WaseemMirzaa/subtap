part of 'widgets.dart';

class UploadProgressSubmitButtons extends StatelessWidget {
  const UploadProgressSubmitButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadProgressController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Validation message
            Obx(() => !controller.isFormValid
                ? Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.validationMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),

            // Submit Progress button
            Obx(() => CustomButton(
                  text: 'Submit Progress',
                  onTap:
                      controller.isFormValid && !controller.isSubmitting.value
                          ? () => controller.showConfirmationModal()
                          : null,
                  color: controller.isFormValid
                      ? AppColor.mutedGold
                      : Colors.grey[300]!,
                  textColor: Colors.white,
                  fontWeight: FontWeight.w400,
                  radius: 14,
                )),

            const SizedBox(height: 12),

            // Mark Job as Complete button (conditional)
            Obx(() => controller.isFormValid
                ? CustomButton(
                    text: 'Mark Job as Complete',
                    onTap: !controller.isSubmitting.value
                        ? () => controller.markJobComplete()
                        : null,
                    color: AppColor.white,
                    textColor: AppColor.black,
                    fontWeight: FontWeight.w400,
                    radius: 14,
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
