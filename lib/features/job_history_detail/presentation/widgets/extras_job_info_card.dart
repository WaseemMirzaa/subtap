part of 'widgets.dart';

class ExtrasJobInfoCard extends StatelessWidget {
  const ExtrasJobInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExtrasController>();

    return Obx(() => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.mutedGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.mutedGold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.work_outline,
                color: AppColor.mutedGold,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  text: '${controller.jobTitle.value} – ${controller.jobId.value}',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColor.mutedGold,
                size: 16,
              ),
              const SizedBox(width: 8),
              CustomText(
                text: 'Budget: \$${controller.budget.value.toStringAsFixed(2)}',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
            ],
          ),
        ],
      ),
    ));
  }
}