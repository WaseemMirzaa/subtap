part of 'widget.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

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
          // Add SafeArea here
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
                              text: 'Property Manager(PM)',
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
                    onTap: () => {Get.toNamed(AppRoutes.jobPost)},
                    text: 'Post a Job',
                    fontSize: 16,
                    radius: 17,
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
  Size get preferredSize => const Size.fromHeight(240);
}
