part of 'widget.dart';

class ChatAppbar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAppbar({super.key});

  @override
  State<ChatAppbar> createState() => _ChatAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(105);
}

class _ChatAppbarState extends State<ChatAppbar> {
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
                          text: "Chat",
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Right-aligned icon
                      InkWell(
                        onTap: () => Get.toNamed(
                            AppRoutes.subcontractornotificationPage),
                        child: Align(
                          alignment: Alignment.centerRight,
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
