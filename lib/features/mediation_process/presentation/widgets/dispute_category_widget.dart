part of 'widgets.dart';

class DisputeCategoryWidget extends StatelessWidget {
  const DisputeCategoryWidget({super.key});

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
          Row(
            children: [
              const CustomText(
                text: 'Dispute Category',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              const Text(' *', style: TextStyle(color: Colors.red)),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.help_outline,
                  size: 20,
                  color: AppColor.mutedGold,
                ),
                onPressed: () => _showHelpDialog(context, 'Dispute Category'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedCategory.value.isEmpty
                    ? null
                    : controller.selectedCategory.value,
                decoration: InputDecoration(
                  hintText: 'Choose dispute category',
                  hintStyle: const TextStyle(color: AppColor.midGray),
                  filled: true,
                  fillColor: AppColor.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColor.darkGrayShade),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColor.darkGrayShade),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColor.mutedGold),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 14,
                  ),
                ),
                items: controller.disputeCategories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(color: AppColor.midGray),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedCategory.value = value;
                  }
                },
              )),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: const Text(
            'Choose the category that best describes your dispute. This helps our mediation team understand your issue better.'),
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
