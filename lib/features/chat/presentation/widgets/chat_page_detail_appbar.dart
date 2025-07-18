part of 'widget.dart';

class ChatPageDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String userName;
  final String avatarImage;
  final String? jobTitle;
  final double? rating;

  const ChatPageDetailAppBar({
    super.key,
    required this.userName,
    required this.avatarImage,
    this.jobTitle,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatDetailController>();

    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 90,
      flexibleSpace: Container(
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
                  child: Row(
                    children: [
                      // Back button
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      // User info - flexible to prevent overflow
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'HelveticaNeueMedium',
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 2),
                            Obx(() => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: controller.isOnline.value
                                            ? Colors.green
                                            : AppColor.midGray,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        controller.isOnline.value
                                            ? 'Online'
                                            : 'Offline',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 11,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )),
                            if (jobTitle != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                jobTitle!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Call button
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColor.mutedGold,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        width: 30,
                        height: 30,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.svgsCall,
                            color: Colors.white,
                            width: 16,
                            height: 16,
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

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
