part of 'widgets.dart';

class SubcontractorCard extends StatelessWidget {
  final String name;
  final String expertise;
  final bool isOnline;
  final String avatarImage;
  final bool isFavorite;

  const SubcontractorCard({
    super.key,
    required this.name,
    required this.expertise,
    required this.isOnline,
    required this.avatarImage,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: AppColor.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(avatarImage),
                  ),
                  if (isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'HelveticaNeueMedium',
                            ),
                            maxLines: 1,
                          ),
                        ),
                        kGap20,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            isFavorite
                                ? SvgPicture.asset(Assets.svgsFavorite)
                                : SvgPicture.asset(Assets.svgsUnfav),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            expertise,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColor.midGray,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'HelveticaNeueMedium',
                            ),
                            maxLines: 1,
                          ),
                        ),
                        kGap20,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.offAllNamed(AppRoutes.mainPageWithNavBar);
                                Get.snackbar(
                                  'Success',
                                  'Invited successfully',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: AppColor.white,
                                  margin: const EdgeInsets.all(16),
                                  duration: const Duration(seconds: 3),
                                );
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Invite',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.mutedGold,
                                  fontFamily: 'HelveticaNeueMedium',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
