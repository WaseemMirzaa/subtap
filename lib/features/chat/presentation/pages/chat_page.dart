part of 'pages.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final ChatController _controller = Get.put(ChatController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const ChatAppbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          _showNewChatOptions();
        },
        backgroundColor: AppColor.mutedGold,
        child: const Icon(Icons.add_comment, color: Colors.white),
      ),
      body: Column(
        children: [
          EnhancedSearchBar(
            controller: _searchController,
            onChanged: _controller.updateSearchQuery,
            hintText: 'Search chats, messages, jobs...',
          ),
          Expanded(
            child: Obx(() {
              if (_controller.filteredChats.isEmpty &&
                  _controller.searchQuery.isEmpty) {
                return const EmptyChatState();
              }

              if (_controller.filteredChats.isEmpty &&
                  _controller.searchQuery.isNotEmpty) {
                return _buildNoSearchResults();
              }

              return _buildChatList();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: _controller.filteredChats.length,
      itemBuilder: (context, index) {
        final chat = _controller.filteredChats[index];
        return EnhancedChatCard(
          chatThread: chat,
          onTap: () => _navigateToChat(chat),
          onArchive: () => _controller.archiveChat(chat.id),
          onPin: () => _controller.togglePin(chat.id),
          onQuickReply: () => _showQuickReply(chat),
        );
      },
    );
  }

  Widget _buildNoSearchResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColor.lightGray.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No results for "${_controller.searchQuery.value}"',
            style: const TextStyle(
              fontSize: 18,
              color: AppColor.midGray,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try searching for names, messages, or job titles',
            style: TextStyle(
              fontSize: 14,
              color: AppColor.lightGray,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToChat(ChatThread chat) {
    // Simulate typing status for demo
    _controller.setTypingStatus(chat.id, true);
    Future.delayed(const Duration(seconds: 3), () {
      _controller.setTypingStatus(chat.id, false);
    });

    Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => ChatDetailPage(
          userName: chat.participantName,
          avatarImage: chat.participantAvatar,
        ),
      ),
    );
  }

  void _showQuickReply(ChatThread chat) {
    final TextEditingController replyController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Reply to ${chat.participantName}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: replyController,
              maxLines: 3,
              style: const TextStyle(color: AppColor.midGray),
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: const TextStyle(color: AppColor.midGray),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColor.midGray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColor.mutedGold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Send',
                    color: AppColor.mutedGold,
                    textColor: Colors.white,
                    onTap: () {
                      if (replyController.text.isNotEmpty) {
                        Get.back();
                        Get.snackbar(
                          'Message Sent',
                          'Quick reply sent to ${chat.participantName}',
                        );
                      }
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

  void _showNewChatOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Start New Chat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.midGray,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.work, color: AppColor.mutedGold),
              title: const Text(
                'Recent PMs to Chat With',
                style: TextStyle(color: AppColor.midGray),
              ),
              subtitle: const Text(
                'Property Managers from your recent jobs',
                style: TextStyle(color: AppColor.midGray),
              ),
              onTap: () {
                Get.back();
                Get.snackbar(
                    'Coming Soon', 'Recent PMs feature will be available soon');
              },
            ),
            ListTile(
              leading: const Icon(Icons.group, color: AppColor.mutedGold),
              title: const Text(
                'Group Chat per Job',
                style: TextStyle(color: AppColor.midGray),
              ),
              subtitle: const Text(
                'Chat with PM + multiple subcontractors',
                style: TextStyle(color: AppColor.midGray),
              ),
              onTap: () {
                Get.back();
                Get.snackbar(
                    'Coming Soon', 'Group chat feature will be available soon');
              },
            ),
          ],
        ),
      ),
    );
  }
}
