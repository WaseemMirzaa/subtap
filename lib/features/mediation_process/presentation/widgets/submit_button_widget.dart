part of 'widgets.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MediationProcessPageController>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.mutedGold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColor.mutedGold,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Obx(() => ElevatedButton(
                        onPressed: controller.isFormValid &&
                                !controller.isSubmitting.value
                            ? () => controller.showSummaryModal()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.mutedGold,
                          disabledBackgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: controller.isSubmitting.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text(
                                'Submit Mediation Request',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
