part of 'widgets.dart';

class SubcontractorJobHistoryDetailAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String jobTitle;

  const SubcontractorJobHistoryDetailAppbar({
    super.key,
    required this.jobTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 105,
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
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: jobTitle,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          text: 'Job History',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.white.withOpacity(0.8),
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
  Size get preferredSize => const Size.fromHeight(105);
}
