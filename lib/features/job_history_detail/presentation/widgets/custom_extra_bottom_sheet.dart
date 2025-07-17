part of 'widgets.dart';

class CustomExtraBottomSheet extends StatelessWidget {
  final String? jobTitle;
  final String? jobId;
  final double? budget;

  const CustomExtraBottomSheet({
    super.key,
    this.jobTitle,
    this.jobId,
    this.budget,
  });

  @override
  Widget build(BuildContext context) {
    // Use Get.find instead of Get.put to avoid recreating controller
    final controller = Get.find<ExtrasController>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.9,
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const ExtrasBottomSheetHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const ExtrasJobInfoCard(),
                  const SizedBox(height: 16),
                  const ExtrasHelperText(),
                  const SizedBox(height: 20),
                  const ExtrasLineItemsList(),
                  const SizedBox(height: 20),
                  const ExtrasTotalPreview(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          const ExtrasBottomButtons(),
        ],
      ),
    );
  }
}
