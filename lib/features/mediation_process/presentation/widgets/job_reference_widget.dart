part of 'widgets.dart';

class JobReferenceWidget extends StatelessWidget {
  const JobReferenceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MediationProcessPageController>();
    
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
            text: 'Job Reference ID',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            fillColor: AppColor.white,
            controller: controller.jobReferenceController,
            borderColor: AppColor.darkGrayShade,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 14,
            ),
            borderRadius: 10,
            hintText: 'e.g., JOB-456',
            fontStyle: FontStyle.normal,
            hintTextColor: AppColor.darkGrayShade,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}