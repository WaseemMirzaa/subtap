part of 'pages.dart';

class SupportRequestsPage extends StatelessWidget {
  SupportRequestsPage({super.key});

  // Sample chat data (replace with your actual data source)
  final List<Map<String, dynamic>> chatData = [
    {
      'name': 'imagesChatDavid',
      'avatarImage': Assets.imagesChatDavid,
      'status': 'In Progress',
    },
    {
      'name': 'John Doe',
      'avatarImage': Assets.imagesChatDavid,
      'status': 'Solved',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const MySupportAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Search Bar
              const SearchBarTile(),
              const SizedBox(
                  height: 30), // Replaced kGap30 with SizedBox for clarity
              // Support Request Cards
              ListView.builder(
                shrinkWrap:
                    true, // Ensures ListView takes only the space it needs
                physics:
                    const NeverScrollableScrollPhysics(), // Disables ListView scrolling
                itemCount: chatData.length,
                itemBuilder: (context, index) {
                  final chat = chatData[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16), // Spacer between cards
                    child: MySupportRequestsCard(
                      status: chat['status'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupportDetailPage(
                              userName: chat['name'],
                              avatarImage: chat['avatarImage'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
