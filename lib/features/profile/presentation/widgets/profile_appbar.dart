part of 'widgets.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double avatarRadius = size.width * 0.14;
    final double avatarImageSize = avatarRadius * 2;

    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 293,
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
            padding: const EdgeInsets.fromLTRB(
                16, 16, 16, 16), // Increased top padding
            child: Column(
              children: [
                // Top row with back button (placeholder), title and edit icon
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0), // Additional padding to push content down
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        const SizedBox(width: 25), // Back button placeholder
                        const Expanded(
                          child: Center(
                            child: CustomText(
                              text: 'Profile',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Edit icon with padding to align better
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 4.0), // Adjust this value as needed
                          child: InkWell(
                            onTap: () {
                              Get.offAllNamed(AppRoutes.onboarding);
                              // Handle edit profile action
                            },
                            child: SvgPicture.asset(
                              Assets.svgsExitDoor,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kGap25,
                // Rest of your content remains the same
                CustomCircleAvatar(
                  radius: avatarRadius,
                  child: Image(
                    image: const AssetImage(Assets.imagesAvatarImage),
                    width: avatarImageSize,
                    height: avatarImageSize,
                    fit: BoxFit.cover,
                  ),
                ),
                kGap20,
                const CustomText(
                  text: 'Sophia Anderson',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                const CustomText(
                  text: '@Sophiaanderson',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(293);
}
