part of 'widgets.dart';

class MySupportDetailAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String userName;
  final String avatarImage;

  const MySupportDetailAppbar({
    super.key,
    required this.userName,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 80,
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
                      // Back button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      // Centered title with userName
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Id# 12917150',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                      ),
                      // Right-aligned avatar with circular Container and SVG
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

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
