part of 'pages.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> chatData = [
    {
      'name': 'Michael Thompson',
      'isOnline': true,
      'avatarImage': Assets.imagesChatMichael,
      'unreadCount': '1d'
    },
    {
      'name': 'Sarah Johnson',
      'isOnline': true,
      'avatarImage': Assets.imagesChatDavid,
      'unreadCount': '1d'
    },
    {
      'name': 'David Wilson',
      'isOnline': true,
      'avatarImage': Assets.imagesChatSarah,
      'unreadCount': '1d'
    },
    {
      'name': 'Laura Martinez',
      'isOnline': true,
      'avatarImage': Assets.imagesChatLaura,
      'unreadCount': '1d'
    },
    {
      'name': 'James Brown',
      'isOnline': true,
      'avatarImage': Assets.imagesChatJhonson,
      'unreadCount': '1d'
    },
  ];

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const ChatAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBarTile(
                controller: _searchController,
                onSearch: () {},
                hintText: 'Search by Name',
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                final chat = chatData[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailPage(
                          userName: chat['name'],
                          avatarImage: chat['avatarImage'],
                        ),
                      ),
                    );
                  },
                  child: ChatCard(
                    name: chat['name'],
                    unreadCount: chat['unreadCount'],
                    isOnline: chat['isOnline'],
                    avatarImage: chat['avatarImage'],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
