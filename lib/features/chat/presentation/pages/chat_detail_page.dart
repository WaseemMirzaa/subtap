part of 'pages.dart';

class ChatDetailPage extends StatefulWidget {
  final String userName;
  final String avatarImage;

  const ChatDetailPage({
    super.key,
    required this.userName,
    required this.avatarImage,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatDetailController _chatController = Get.put(ChatDetailController());

  // Enhanced messages with more realistic data
  final List<Map<String, dynamic>> messages = [
    {
      'id': '1',
      'text':
          'Hey! The permit inspection is scheduled for tomorrow at 2 PM. Can you make it?',
      'isMe': false,
      'time': '10:30 AM',
      'status': 'delivered',
      'hasAttachment': false,
      'replyTo': null,
    },
    {
      'id': '2',
      'text': 'Yes, I\'ll be there. Should I bring the updated blueprints?',
      'isMe': true,
      'time': '10:32 AM',
      'status': 'read',
      'hasAttachment': false,
      'replyTo': null,
    },
    {
      'id': '3',
      'text': 'Actually, there\'s a delay. Inspector moved it to Friday 3 PM.',
      'isMe': false,
      'time': '11:15 AM',
      'status': 'delivered',
      'hasAttachment': false,
      'replyTo': null,
    },
    {
      'id': '4',
      'text': 'Here\'s the updated scope document',
      'isMe': true,
      'time': '11:20 AM',
      'status': 'read',
      'hasAttachment': true,
      'attachmentType': 'pdf',
      'attachmentName': 'Updated_Scope_Job123.pdf',
      'replyTo': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _chatController.setOnlineStatus(true);
    _chatController.startTypingSimulation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'text': _messageController.text,
          'isMe': true,
          'time': _formatCurrentTime(),
          'status': 'sent',
          'hasAttachment': false,
          'replyTo': null,
        });
        _messageController.clear();
      });
      _scrollToBottom();
    }
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatDetailController>();

    return SubtapScaffold(
      backgroundColor: AppColor.lightGray,
      appBar: ChatPageDetailAppBar(
        userName: widget.userName,
        avatarImage: widget.avatarImage,
        jobTitle: 'Kitchen Renovation - Job #123',
        rating: 4.8,
      ),
      body: Column(
        children: [
          // Load earlier messages
          LoadEarlierMessages(
            onLoadMore: _loadEarlierMessages,
            isLoading: _isLoadingEarlier,
          ),
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: messages.length + (controller.isTyping.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && controller.isTyping.value) {
                  return const TypingIndicator(userName: 'Michael');
                }

                final message = messages[index];
                return EnhancedMessageBubble(
                  id: message['id'],
                  text: message['text'],
                  isMe: message['isMe'],
                  time: message['time'],
                  avatar: !message['isMe'] ? widget.avatarImage : null,
                  status: message['status'],
                  hasAttachment: message['hasAttachment'] ?? false,
                  attachmentType: message['attachmentType'],
                  attachmentName: message['attachmentName'],
                  replyTo: message['replyTo'],
                  onLongPress: () => _showMessageOptions(message),
                  onReply: () => _replyToMessage(message),
                );
              },
            ),
          ),
          // Typing indicator
          Obx(() => controller.isTyping.value
              ? const TypingIndicator(userName: 'Michael')
              : const SizedBox.shrink()),
          // Input area
          Obx(() => EnhancedChatInput(
                controller: _messageController,
                onSend: _sendMessage,
                onAttachment: _showAttachmentOptions,
                replyingTo: controller.replyingToMessage.value.isNotEmpty
                    ? controller.replyingToMessage.value
                    : null,
                onClearReply: () => controller.clearReply(),
              )),
        ],
      ),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AttachmentOptionsSheet(
        onAttachmentSelected: _handleAttachment,
      ),
    );
  }

  void _handleAttachment(String type) {
    switch (type) {
      case 'camera':
        _addImageMessage('Camera photo captured');
        break;
      case 'gallery':
        _addImageMessage('Photo from gallery');
        break;
      case 'pdf':
        _addPdfMessage('Contract_Amendment.pdf');
        break;
      case 'job':
        _addJobLinkMessage();
        break;
    }
  }

  void _addImageMessage(String description) {
    setState(() {
      messages.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'text': description,
        'isMe': true,
        'time': _formatCurrentTime(),
        'status': 'sent',
        'hasAttachment': true,
        'attachmentType': 'image',
        'attachmentName': 'work_progress.jpg',
        'replyTo': null,
      });
    });
    _scrollToBottom();
  }

  void _addPdfMessage(String fileName) {
    setState(() {
      messages.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'text': 'Document attached',
        'isMe': true,
        'time': _formatCurrentTime(),
        'status': 'sent',
        'hasAttachment': true,
        'attachmentType': 'pdf',
        'attachmentName': fileName,
        'replyTo': null,
      });
    });
    _scrollToBottom();
  }

  void _addJobLinkMessage() {
    setState(() {
      messages.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'text': '',
        'isMe': true,
        'time': _formatCurrentTime(),
        'status': 'sent',
        'hasAttachment': true,
        'attachmentType': 'job',
        'attachmentName': 'Kitchen Renovation - Job #123',
        'replyTo': null,
      });
    });
    _scrollToBottom();
  }

  void _showMessageOptions(Map<String, dynamic> message) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => MessageOptionsSheet(
        messageId: message['id'],
        messageText: message['text'],
        isMe: message['isMe'],
        onOptionSelected: _handleMessageOption,
      ),
    );
  }

  void _handleMessageOption(String action, String messageId) {
    final controller = Get.find<ChatDetailController>();

    if (action == 'reply') {
      final message = messages.firstWhere((m) => m['id'] == messageId);
      controller.setReplyingTo(messageId, message['text']);
    } else if (action == 'edit') {
      _editMessage(messageId);
    } else if (action == 'delete') {
      _deleteMessage(messageId);
    } else if (action.startsWith('react_')) {
      final emoji = action.split('_')[1];
      _addReaction(messageId, emoji);
    }
  }

  void _editMessage(String messageId) {
    // Implementation for editing message
    Get.snackbar('Edit', 'Edit functionality coming soon');
  }

  void _deleteMessage(String messageId) {
    setState(() {
      messages.removeWhere((m) => m['id'] == messageId);
    });
  }

  void _addReaction(String messageId, String emoji) {
    // Implementation for adding reactions
    Get.snackbar('React', 'Added reaction: $emoji');
  }

  void _replyToMessage(Map<String, dynamic> message) {
    final controller = Get.find<ChatDetailController>();
    controller.setReplyingTo(message['id'], message['text']);
  }

  bool _isLoadingEarlier = false;

  void _loadEarlierMessages() {
    setState(() {
      _isLoadingEarlier = true;
    });

    // Simulate loading earlier messages
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.insertAll(0, [
          {
            'id': 'earlier_1',
            'text': 'Good morning! Ready to start the kitchen project today?',
            'isMe': false,
            'time': '8:30 AM',
            'status': 'delivered',
            'hasAttachment': false,
            'replyTo': null,
          },
          {
            'id': 'earlier_2',
            'text': 'Yes, I\'ll be there by 9 AM with all the materials.',
            'isMe': true,
            'time': '8:35 AM',
            'status': 'read',
            'hasAttachment': false,
            'replyTo': null,
          },
        ]);
        _isLoadingEarlier = false;
      });
    });
  }
}
