part of 'widget.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final bool isOnline;
  final String avatarImage;
  final String? unreadCount;

  const ChatCard({
    super.key,
    required this.name,
    required this.isOnline,
    required this.avatarImage,
    this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(avatarImage),
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                      if (unreadCount != null)
                        Text(
                          unreadCount!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColor.midGray,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Let\'s talk on Wednesday',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColor.midGray,
                      fontFamily: 'HelveticaNeueMedium',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
