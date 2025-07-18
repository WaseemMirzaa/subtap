part of 'widget.dart';

class MessageOptionsSheet extends StatelessWidget {
  final String messageId;
  final String messageText;
  final bool isMe;
  final Function(String action, String messageId) onOptionSelected;

  const MessageOptionsSheet({
    super.key,
    required this.messageId,
    required this.messageText,
    required this.isMe,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColor.lightGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Message Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildMessagePreview(),
            const SizedBox(height: 20),
            _buildOptionItem(
              icon: Icons.reply,
              title: 'Reply',
              onTap: () {
                Navigator.pop(context);
                onOptionSelected('reply', messageId);
              },
            ),
            if (isMe) ...[
              _buildOptionItem(
                icon: Icons.edit,
                title: 'Edit',
                subtitle: 'Available for 2 minutes',
                onTap: () {
                  Navigator.pop(context);
                  onOptionSelected('edit', messageId);
                },
              ),
              _buildOptionItem(
                icon: Icons.delete,
                title: 'Delete',
                isDestructive: true,
                onTap: () {
                  Navigator.pop(context);
                  onOptionSelected('delete', messageId);
                },
              ),
            ],
            _buildReactionRow(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagePreview() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.whiteSmoke,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        messageText,
        style: const TextStyle(
          fontSize: 14,
          color: AppColor.midGray,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    String? subtitle,
    bool isDestructive = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : AppColor.mutedGold,
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDestructive ? Colors.red : AppColor.black,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.midGray,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionRow() {
    final reactions = ['👍', '❤️', '😂', '😮', '😢', '😡'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'React with emoji',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: reactions.map((emoji) {
            return GestureDetector(
              onTap: () {
                Get.back();
                onOptionSelected('react_$emoji', messageId);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.whiteSmoke,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
