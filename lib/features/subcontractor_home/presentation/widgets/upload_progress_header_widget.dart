part of 'widgets.dart';

class UploadProgressHeaderWidget extends StatelessWidget {
  const UploadProgressHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadProgressController>();
    
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.mutedGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.mutedGold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: AppColor.mutedGold,
            size: 20,
          ),
          const SizedBox(height: 8),
          const Text(
            'Use this form to share what work you\'ve completed. Photos help speed up payment!',
            style: TextStyle(
              fontSize: 14,
              color: AppColor.midGray,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Job: ${controller.jobTitle.value} – ${controller.jobId.value}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                controller.dueDate.value,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColor.midGray,
                ),
              ),
              if (controller.extrasTotal.value > 0) ...[
                const SizedBox(height: 4),
                Text(
                  'Extras Total: \$${controller.extrasTotal.value.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.mutedGold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          )),
        ],
      ),
    );
  }
}