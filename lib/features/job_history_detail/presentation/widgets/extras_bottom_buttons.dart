part of 'widgets.dart';

class ExtrasBottomButtons extends StatelessWidget {
  const ExtrasBottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExtrasController>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Validation errors
            Obx(() => !controller.isFormValid && controller.lineItems.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Please fill in all required fields with valid values.',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink()),

            // Review step
            Obx(() => controller.showReviewStep.value
                ? const ExtrasReviewStep()
                : const ExtrasSubmitButtons()),
          ],
        ),
      ),
    );
  }
}