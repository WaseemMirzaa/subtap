part of 'widget.dart';

class EnhancedChatCard extends StatelessWidget {
  final ChatThread chatThread;
  final VoidCallback onTap;
  final VoidCallback onArchive;
  final VoidCallback onPin;
  final VoidCallback onQuickReply;

  const EnhancedChatCard({
    super.key,
    required this.chatThread,
    required this.onTap,
    required this.onArchive,
    required this.onPin,
    required this.onQuickReply,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();

    return Semantics(
      label: _getSemanticLabel(),
      child: Dismissible(
        key: Key('chat_${chatThread.id}'),
        background: _buildSwipeBackground(isLeftSwipe: false),
        secondaryBackground: _buildSwipeBackground(isLeftSwipe: true),
        confirmDismiss: (direction) async {
          // Return false to prevent automatic dismissal
          return false;
        },
        onDismissed: (direction) {
          // This won't be called now due to confirmDismiss returning false
        },
        child: GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            controller.markAsRead(chatThread.id);
            onTap();
          },
          onLongPress: () {
            HapticFeedback.heavyImpact();
            _showLongPressMenu(context);
          },
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              // Swiped right to left
              HapticFeedback.mediumImpact();
              onQuickReply();
            } else if (details.primaryVelocity! < 0) {
              // Swiped left to right
              HapticFeedback.mediumImpact();
              onArchive();
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
              border: chatThread.isPinned
                  ? Border.all(color: AppColor.mutedGold, width: 1)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: 12),
                Expanded(child: _buildContent()),
                _buildTrailingInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final controller = Get.find<ChatController>();

    return Stack(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  chatThread.isRead ? Colors.transparent : AppColor.mutedGold,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: chatThread.participantAvatar.isNotEmpty
                ? Image.asset(
                    chatThread.participantAvatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildInitialsAvatar(),
                  )
                : _buildInitialsAvatar(),
          ),
        ),
        if (chatThread.isOnline)
          Positioned(
            right: 2,
            bottom: 2,
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
        if (chatThread.isPinned)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: AppColor.mutedGold,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.push_pin,
                size: 10,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInitialsAvatar() {
    final controller = Get.find<ChatController>();
    final initials = controller.getInitials(chatThread.participantName);
    final color = controller.getInitialsColor(chatThread.participantName);

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                chatThread.participantName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      chatThread.isRead ? FontWeight.w500 : FontWeight.bold,
                  color: AppColor.black,
                  fontFamily: 'HelveticaNeueMedium',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (chatThread.unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColor.mutedGold,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${chatThread.unreadCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              chatThread.jobIcon,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                chatThread.jobTitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColor.midGray,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Obx(() {
          final controller = Get.find<ChatController>();
          final isTyping = controller.typingStatus[chatThread.id] ?? false;

          if (isTyping) {
            return const Row(
              children: [
                Text(
                  '💬 ',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  'is typing...',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.mutedGold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            );
          }

          return Row(
            children: [
              if (chatThread.hasAttachment) ...[
                Icon(
                  _getAttachmentIcon(),
                  size: 14,
                  color: AppColor.midGray,
                ),
                const SizedBox(width: 4),
              ],
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColor.midGray,
                      fontWeight:
                          chatThread.isRead ? FontWeight.w400 : FontWeight.w500,
                    ),
                    children: _buildMessageSpans(),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (chatThread.isRead)
                const Icon(
                  Icons.done_all,
                  size: 14,
                  color: AppColor.mutedGold,
                ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildTrailingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _getFormattedTime(),
          style: TextStyle(
            fontSize: 11,
            color: AppColor.midGray,
            fontWeight: chatThread.isRead ? FontWeight.w400 : FontWeight.w500,
          ),
        ),
        if (!chatThread.isRead)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColor.mutedGold,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  Widget _buildSwipeBackground({required bool isLeftSwipe}) {
    return Container(
      alignment: isLeftSwipe ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isLeftSwipe ? Colors.red : AppColor.mutedGold,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isLeftSwipe ? Icons.archive : Icons.reply,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            isLeftSwipe ? 'Archive' : 'Reply',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildMessageSpans() {
    final urgentKeywords = [
      'urgent',
      'invoice',
      'delayed',
      'asap',
      'emergency'
    ];
    final message = chatThread.lastMessage;
    final spans = <TextSpan>[];

    final words = message.split(' ');
    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final isUrgent = urgentKeywords.any(
        (keyword) => word.toLowerCase().contains(keyword.toLowerCase()),
      );

      spans.add(TextSpan(
        text: word + (i < words.length - 1 ? ' ' : ''),
        style: TextStyle(
          fontWeight: isUrgent ? FontWeight.bold : FontWeight.normal,
          color: isUrgent ? Colors.red : AppColor.midGray,
        ),
      ));
    }

    return spans;
  }

  IconData _getAttachmentIcon() {
    switch (chatThread.messageType) {
      case MessageType.image:
        return Icons.image;
      case MessageType.document:
        return Icons.attach_file;
      case MessageType.voice:
        return Icons.mic;
      default:
        return Icons.attach_file;
    }
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    final difference = now.difference(chatThread.lastMessageTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '1w+';
    }
  }

  String _getSemanticLabel() {
    final timeText = _getFormattedTime();
    final unreadText = chatThread.unreadCount > 0
        ? '${chatThread.unreadCount} unread messages. '
        : '';

    return 'Chat with ${chatThread.participantName}. $unreadText'
        'Last message: ${chatThread.lastMessage}. Sent $timeText ago.';
  }

  void _showLongPressMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(chatThread.isPinned
                  ? Icons.push_pin_outlined
                  : Icons.push_pin),
              title: Text(chatThread.isPinned ? 'Unpin Chat' : 'Pin to Top'),
              onTap: () {
                Navigator.pop(context);
                onPin();
              },
            ),
            ListTile(
              leading: const Icon(Icons.volume_off),
              title: const Text('Mute Notifications'),
              onTap: () {
                Navigator.pop(context);
                Get.snackbar('Muted', 'Chat notifications muted');
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Archive Chat'),
              onTap: () {
                Navigator.pop(context);
                onArchive();
              },
            ),
          ],
        ),
      ),
    );
  }
}
