part of 'widgets.dart';

class JobHistoryAppbar extends StatefulWidget implements PreferredSizeWidget {
  const JobHistoryAppbar({super.key});

  @override
  State<JobHistoryAppbar> createState() => _JobHistoryAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(105);
}

class _JobHistoryAppbarState extends State<JobHistoryAppbar> {
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
                          text: "Job History",
                          color: AppColor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Right-aligned icon
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Get.toNamed(AppRoutes.notificationPage),
                          child: SvgPicture.asset(
                            Assets.svgsNotification,
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
