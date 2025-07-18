part of 'widget.dart';

class EnhancedChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttachment;
  final String? replyingTo;
  final VoidCallback? onClearReply;

  const EnhancedChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachment,
    this.replyingTo,
    this.onClearReply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          if (replyingTo != null) _buildReplyBar(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Attachment button
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.mutedGold,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: onAttachment,
                  ),
                ),
                const SizedBox(width: 8),
                // Text input
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColor.whiteSmoke),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(color: AppColor.midGray),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'HelveticaNeueRegular',
                          ),
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Send button
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.mutedGold,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: onSend,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColor.whiteSmoke,
        border: Border(
          bottom: BorderSide(color: AppColor.lightGray),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.reply, color: AppColor.mutedGold, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Replying to: $replyingTo',
              style: const TextStyle(
                fontSize: 12,
                color: AppColor.midGray,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16, color: AppColor.midGray),
            onPressed: onClearReply,
          ),
        ],
      ),
    );
  }
}
