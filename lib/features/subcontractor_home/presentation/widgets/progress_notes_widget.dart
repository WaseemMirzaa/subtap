part of 'widgets.dart';

class ProgressNotesWidget extends StatelessWidget {
  const ProgressNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadProgressController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: 'Progress Notes',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              Obx(() => Text(
                    '${controller.progressNotesCharCount.value}/500',
                    style: TextStyle(
                      fontSize: 12,
                      color: controller.progressNotesCharCount.value > 500
                          ? Colors.red
                          : AppColor.midGray,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Describe work completed today',
            style: TextStyle(
              fontSize: 12,
              color: AppColor.midGray,
            ),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: controller.progressNotesController,
            hintText: 'e.g., Finished drywall taping, 2 rooms left',
            hintTextColor: AppColor.midGray,
            fillColor: AppColor.white,
            borderColor: AppColor.darkGrayShade,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            contentPadding: const EdgeInsets.all(12),
          ),
        ],
      ),
    );
  }
}
