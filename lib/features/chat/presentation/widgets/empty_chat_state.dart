part of 'widget.dart';

class EmptyChatState extends StatelessWidget {
  const EmptyChatState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: AppColor.lightGray.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            const Text(
              'No messages yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColor.darkGray,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start chatting with your Property Managers',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.midGray,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Find Jobs',
                    color: AppColor.mutedGold,
                    textColor: Colors.white,
                    onTap: () {
                      Get.toNamed(AppRoutes.newJobs);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Start New Chat',
                    color: AppColor.backgroundColor,
                    textColor: Colors.white,
                    onTap: () {
                      _showNewChatDialog();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showNewChatDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Start New Chat'),
        content:
            const Text('Choose a Property Manager to start chatting with:'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Feature Coming Soon',
                  'New chat feature will be available soon');
            },
            child: const Text('Browse PMs'),
          ),
        ],
      ),
    );
  }
}
