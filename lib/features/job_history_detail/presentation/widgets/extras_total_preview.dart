part of 'widgets.dart';

class ExtrasTotalPreview extends StatelessWidget {
  const ExtrasTotalPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExtrasController>();

    return Obx(() => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.mutedGold.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.mutedGold),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: 'Extras Total:',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
              CustomText(
                text: '\$${controller.getTotalAmount().toStringAsFixed(2)}',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColor.mutedGold,
              ),
            ],
          ),
          if (controller.getTotalAmount() > 0) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColor.white,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This amount will be added to your job total if approved.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    ));
  }
}