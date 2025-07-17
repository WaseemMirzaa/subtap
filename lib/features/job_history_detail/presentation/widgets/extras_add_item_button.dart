part of 'widgets.dart';

class ExtrasAddItemButton extends StatelessWidget {
  const ExtrasAddItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExtrasController>();

    return GestureDetector(
      onTap: controller.addNewLineItem,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColor.white.withOpacity(0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: AppColor.white,
              size: 16,
            ),
            SizedBox(width: 8),
            CustomText(
              text: 'Add Another Item',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
          ],
        ),
      ),
    );
  }
}