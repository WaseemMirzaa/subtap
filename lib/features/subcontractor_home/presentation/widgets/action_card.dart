part of 'widgets.dart';

class ActionCard extends StatelessWidget {
  final String svgAssetPath;
  final String actionText;
  final VoidCallback? onTap;

  const ActionCard({
    super.key,
    required this.svgAssetPath,
    required this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgAssetPath,
              width: 15,
              height: 15,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomText(
                text: actionText,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.midGray,
              ),
            ),
            SvgPicture.asset(
              Assets.svgsArrowForward,
              width: 6,
              height: 11,
              color: AppColor.midGray,
            ),
          ],
        ),
      ),
    );
  }
}
