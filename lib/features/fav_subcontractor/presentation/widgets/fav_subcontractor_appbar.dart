part of 'widgets.dart';

class FavSubcontractorAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  const FavSubcontractorAppbar({super.key});

  @override
  State<FavSubcontractorAppbar> createState() => _FavSubcontractorAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(105);
}

class _FavSubcontractorAppbarState extends State<FavSubcontractorAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 105,
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
                Expanded(
                  child: Stack(
                    children: [
                      // Centered title - takes full width but text is centered
                      const Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Subcontractor (Sub)",
                          color: AppColor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Right-aligned icon
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () =>
                              Get.toNamed(AppRoutes.favoritesSubcontractor),
                          child: SvgPicture.asset(
                            Assets.svgsFavNoti,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
