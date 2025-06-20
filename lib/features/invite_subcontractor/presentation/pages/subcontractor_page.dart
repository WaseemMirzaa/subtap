part of 'pages.dart';

class SubcontractorsPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> subcontractorData = [
    {
      'name': 'Michael James',
      'expertise': 'General Handyman',
      'isOnline': true,
      'avatarImage': Assets.imagesSubcontractorMichael,
      'isFavorite': true, // First person is favorite
    },
    {
      'name': 'Sarah Jhonson',
      'expertise': 'General Handyman',
      'isOnline': true,
      'avatarImage': Assets.imagesSubcontractorSarah,
      'isFavorite': true, // Second person is favorite
    },
    {
      'name': 'David Wilson',
      'expertise': 'General Handyman',
      'isOnline': true,
      'avatarImage': Assets.imagesSubcontractorDavid,
      'isFavorite': false, // Rest are unfavorite
    },
    {
      'name': 'Laura Martinez',
      'expertise': 'General Handyman',
      'isOnline': true,
      'avatarImage': Assets.imagesSubcontractorLaura,
      'isFavorite': false,
    },
    {
      'name': 'James Brown',
      'expertise': 'General Handyman',
      'isOnline': true,
      'avatarImage': Assets.imagesSubcontractorJames,
      'isFavorite': false,
    },
    {
      'name': 'Daniel Charles',
      'expertise': 'General Handyman',
      'isOnline': true,
      'avatarImage': Assets.imagesSubcontractorBrown,
      'isFavorite': false,
    },
  ];

  SubcontractorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const InviteSubcontractorAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SearchBarTile(
                controller: _searchController,
                onSearch: () {},
                hintText: 'Search by name',
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subcontractorData.length,
              itemBuilder: (context, index) {
                final subcontractor = subcontractorData[index];
                return SubcontractorCard(
                  name: subcontractor['name'],
                  expertise: subcontractor['expertise'],
                  isOnline: subcontractor['isOnline'],
                  avatarImage: subcontractor['avatarImage'],
                  isFavorite: subcontractor['isFavorite'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
