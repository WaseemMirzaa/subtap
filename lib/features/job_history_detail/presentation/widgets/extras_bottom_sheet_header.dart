part of 'widgets.dart';

class ExtrasBottomSheetHeader extends StatelessWidget {
  const ExtrasBottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColor.lightGray,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          
          // Title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: 'Request Extras',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: AppColor.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}