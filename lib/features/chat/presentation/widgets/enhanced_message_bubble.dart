part of 'widget.dart';

class EnhancedMessageBubble extends StatelessWidget {
  final String id;
  final String text;
  final bool isMe;
  final String time;
  final String? avatar;
  final String status;
  final bool hasAttachment;
  final String? attachmentType;
  final String? attachmentName;
  final String? replyTo;
  final VoidCallback? onLongPress;
  final VoidCallback? onReply;

  const EnhancedMessageBubble({
    super.key,
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
    this.avatar,
    required this.status,
    this.hasAttachment = false,
    this.attachmentType,
    this.attachmentName,
    this.replyTo,
    this.onLongPress,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe && avatar != null) ...[
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(avatar!),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (replyTo != null) _buildReplyPreview(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isMe ? AppColor.backgroundColor : AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: isMe
                            ? const Radius.circular(20)
                            : const Radius.circular(4),
                        bottomRight: isMe
                            ? const Radius.circular(4)
                            : const Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hasAttachment) _buildAttachment(),
                        if (text.isNotEmpty) ...[
                          Text(
                            text,
                            style: TextStyle(
                              color: isMe ? AppColor.white : AppColor.black,
                              fontFamily: 'HelveticaNeueMedium',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        _buildStatusIcon(),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (isMe) const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyPreview() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        replyTo!,
        style: const TextStyle(
          fontSize: 12,
          color: AppColor.midGray,
          fontStyle: FontStyle.italic,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildAttachment() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMe ? AppColor.mutedBlue : AppColor.whiteSmoke,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getAttachmentIcon(),
            color: AppColor.mutedGold,
            size: 20,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              attachmentName ?? 'Attachment',
              style: TextStyle(
                fontSize: 13,
                color: isMe ? AppColor.white : AppColor.midGray,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getAttachmentIcon() {
    switch (attachmentType) {
      case 'image':
        return Icons.image;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'job':
        return Icons.work;
      default:
        return Icons.attach_file;
    }
  }

  Widget _buildStatusIcon() {
    switch (status) {
      case 'sent':
        return const Icon(Icons.done, size: 14, color: AppColor.midGray);
      case 'delivered':
        return const Icon(Icons.done_all, size: 14, color: AppColor.midGray);
      case 'read':
        return const Icon(Icons.done_all, size: 14, color: AppColor.mutedGold);
      default:
        return const SizedBox.shrink();
    }
  }
}
