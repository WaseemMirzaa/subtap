part of 'widgets.dart';

class SubcontractorHomeAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const SubcontractorHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double avatarRadius = size.width * 0.10;
    final double avatarImageSize = avatarRadius * 2;

    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: Container(
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Title row
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Center(
                            child: CustomText(
                              text: 'Home',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(AppRoutes.notificationPage),
                        child: SvgPicture.asset(
                          Assets.svgsNotification,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                kGap20,
                // User info row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      CustomCircleAvatar(
                        radius: avatarRadius,
                        child: Image(
                          image: const AssetImage(Assets.imagesAvatarImage),
                          width: avatarImageSize,
                          height: avatarImageSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Hi, Alex Jerome!',
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                            ),
                            kGap10,
                            CustomText(
                              text: 'Customer',
                              decorationColor: AppColor.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                kGap20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: CustomButton(
                    text: 'Find Jobs',
                    fontSize: 16,
                    radius: 17,
                    enableIcon: true,
                    icon: SvgPicture.asset(
                      Assets.svgsIconAwesomeSearch,
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Get.toNamed(AppRoutes.subcontractorJob);
                    },
                  ),
                ),
                kGap20,
                Container(
                  width: 335,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  constraints: const BoxConstraints(minHeight: 80), // Optional
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Flexible(
                              child: CustomText(
                                text: '\$3,650',
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: AppColor.mutedGold,
                              ),
                            ),
                            Align(
                              alignment: const Alignment(
                                  0.7, -1.0), // Slightly left and top-aligned
                              child: Transform.translate(
                                offset: const Offset(
                                    0, 13), // Move downwards by 6 pixels
                                child: CustomButton(
                                  color: AppColor.darkBlueShade,
                                  text: 'Cash Out',
                                  fontSize: 11,
                                  height: 38,
                                  width: 80,
                                  radius: 12,
                                  onTap: () {
                                    // Cash out logic
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: 'Available Cash',
                            fontSize: 12,
                            color: AppColor.midGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(350); // Increased to avoid clipping
}
