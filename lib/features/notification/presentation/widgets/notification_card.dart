part of 'widgets.dart';

class NotificationCard extends StatelessWidget {
  final String description;
  final String avatarImage;

  const NotificationCard({
    super.key,
    required this.description,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Add this line
        children: [
          Align(
            alignment:
                Alignment.topCenter, // This will align the avatar upwards
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(avatarImage),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColor.grayShade,
                    fontFamily: 'HelveticaNeueMedium',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
