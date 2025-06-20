part of 'widgets.dart';

class SubcontractorProfileCard extends StatelessWidget {
  final String title;
  final String svgAsset;
  final VoidCallback? onTap;

  const SubcontractorProfileCard({
    super.key,
    required this.title,
    required this.svgAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ), // Reduced vertical padding
          child: Row(
            children: [
              // Smaller circular avatar with SVG
              Container(
                width: 36, // Adjust width as needed
                height: 36, // Adjust height as needed
                decoration: BoxDecoration(
                  color: AppColor.customOffWhite,
                  borderRadius:
                      BorderRadius.circular(10), // Adjust corner radius
                ),
                child: Center(
                  child: SvgPicture.asset(
                    svgAsset,
                    width: 18, // Keep icon size or adjust
                    height: 19, // Keep icon size or adjust
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Title
              Expanded(
                child: CustomText(
                  text: title,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                ),
              ),
              // Forward icon
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: AppColor.darkGrayShade),
            ],
          ),
        ),
      ),
    );
  }
}
