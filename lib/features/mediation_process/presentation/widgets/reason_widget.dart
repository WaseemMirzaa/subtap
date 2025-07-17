part of 'widgets.dart';

class ReasonWidget extends StatelessWidget {
  const ReasonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MediationProcessPageController>();
    final screenHeight = MediaQuery.of(context).size.height;
    
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
            children: [
              const CustomText(
                text: 'Reason',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              const Text(' *', style: TextStyle(color: Colors.red)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.help_outline, size: 20),
                onPressed: () => _showHelpDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextField(
            fontStyle: FontStyle.normal,
            fillColor: AppColor.white,
            controller: controller.reasonController,
            borderColor: AppColor.darkGrayShade,
            hintText: 'e.g., "PM didn\'t pay for completed painting work."',
            hintTextColor: AppColor.darkGrayShade,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            height: screenHeight * 0.13,
            contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: 14,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Reason is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Describe your issue in detail',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '${controller.reasonCharCount.value}/1000',
                style: TextStyle(
                  fontSize: 12,
                  color: controller.reasonCharCount.value > 1000 
                      ? Colors.red 
                      : Colors.grey[600],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to write a good reason'),
        content: const Text('Be specific about what happened, when it occurred, and how it affected you. Include relevant details that will help our mediation team understand the situation.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}