part of 'widgets.dart';

class NotificationAppbar extends StatefulWidget implements PreferredSizeWidget {
  const NotificationAppbar({super.key});

  @override
  State<NotificationAppbar> createState() => _NotificationAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(105);
}

class _NotificationAppbarState extends State<NotificationAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 105, // Decreased height
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColor.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: Container(
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: const SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                SizedBox(height: 16),
                // This is the row with centered JobPost and right-aligned notification
                Expanded(
                  child: Center(
                    child: CustomText(
                      text: 'Notifications',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
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
}
