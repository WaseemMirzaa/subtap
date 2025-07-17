part of 'widgets.dart';

class AdditionalCommentsWidget extends StatelessWidget {
  const AdditionalCommentsWidget({super.key});

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
          const CustomText(
            text: 'Additional Comments',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          const Text(
            'List any issues, delays, or notes to PM',
            style: TextStyle(
              fontSize: 12,
              color: AppColor.midGray,
            ),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: controller.additionalCommentsController,
            hintText: 'e.g., Ran short on materials – returning Monday',
            hintTextColor: AppColor.midGray,
            fillColor: AppColor.white,
            borderColor: AppColor.darkGrayShade,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            contentPadding: const EdgeInsets.all(12),
          ),
        ],
      ),
    );
  }
}
