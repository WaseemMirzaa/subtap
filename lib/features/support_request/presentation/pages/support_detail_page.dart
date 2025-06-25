part of 'pages.dart';

class SupportDetailPage extends StatefulWidget {
  final String userName;
  final String avatarImage;

  const SupportDetailPage({
    super.key,
    required this.userName,
    required this.avatarImage,
  });

  @override
  State<SupportDetailPage> createState() => _SupportDetailPageState();
}

class _SupportDetailPageState extends State<SupportDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  // Reordered messages list to match the requested order
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hey, Just Checking in--are you working on the Figma file?',
      'isMe': false,
      'time': '10:30 AM'
    },
    {
      'text':
          'Hey! I was  about  to get started,but i actually need to cancel the order for now.',
      'isMe': true,
      'time': '10:32 AM',
    },
    // Optionally include other messages
    {'text': 'Okay. Is everything alright?', 'isMe': false, 'time': '10:35 AM'},
    {
      'text':
          "Yeah, just some scheduling issues on my end.I didn't want to delay your project.",
      'isMe': true,
      'time': '10:36 AM', // Adjusted time to maintain chronological sense
    },
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to the bottom after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
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
    return SubtapScaffold(
      appBar: MySupportDetailAppbar(
        userName: widget.userName,
        avatarImage: widget.avatarImage,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true, // Keep reverse: true for chat-like experience
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                // Since reverse is true, reverse the index to access messages
                final message = messages[messages.length - 1 - index];
                return MessageBubbleCard(
                  text: message['text'],
                  isMe: message['isMe'],
                  time: message['time'],
                  avatar: message['isMe'] ? null : widget.avatarImage,
                );
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.backgroundColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: AppColor.lightGray,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'HelveticaNeueRegular',
                        ),
                        hintText: 'Write message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide:
                              const BorderSide(color: AppColor.whiteSmoke),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide:
                              const BorderSide(color: AppColor.whiteSmoke),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide:
                              const BorderSide(color: AppColor.whiteSmoke),
                        ),
                      ),
                    ),
                  ),
                )),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.mutedGold,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // if (_messageController.text.isNotEmpty) {
                      //   setState(() {
                      //     messages.add({
                      //       'text': _messageController.text,
                      //       'isMe': true,
                      //       'time': FormatCurrentTime(), // Use formatted time
                      //     });
                      //     _messageController.clear();
                      //   });
                      //   _scrollToBottom();
                      // }
                    },
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
