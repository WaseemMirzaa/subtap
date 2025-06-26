part of 'pages.dart';

class FavoritesSubcontractorPage extends StatefulWidget {
  const FavoritesSubcontractorPage({super.key});

  @override
  State<FavoritesSubcontractorPage> createState() =>
      _FavoritesSubcontractorPageState();
}

class _FavoritesSubcontractorPageState
    extends State<FavoritesSubcontractorPage> {
  final List<Map<String, dynamic>> subcontractorData = [
    {
      'name': 'Michael Thompson',
      'isOnline': true,
      'avatarImage': Assets.imagesFavSubcontractorMichael,
      'description': 'General Handyman'
    },
    {
      'name': 'Sarah Johnson',
      'isOnline': true,
      'avatarImage': Assets.imagesFavSubcontractorSarah,
      'description': 'HVAC (Heating, Ventilation, AC)'
    },
    {
      'name': 'David Wilson',
      'isOnline': true,
      'avatarImage': Assets.imagesFavSubconstractorDavid,
      'description': 'Security System Install'
    },
    {
      'name': 'Laura Martinez',
      'isOnline': true,
      'avatarImage': Assets.imagesFavSubcontractorLaura,
      'description': 'Plumbing'
    },
    {
      'name': 'James Brown',
      'isOnline': true,
      'avatarImage': Assets.imagesFavSubcontractorJames,
      'description': 'Drywall, Finishing'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      isAppBar: true,
      appBarSecond: const FavoritiesSubcontractorAppbar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SearchBarTile(
              hintText: 'Search by name',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subcontractorData.length,
              itemBuilder: (context, index) {
                final subcontractor = subcontractorData[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.jobRequest,
                      arguments: {
                        'initialTitle': subcontractor['description'],
                        'subcontractor': subcontractor,
                      },
                    );
                  },
                  child: FavSubcontractorCard(
                    isFav: true,
                    favIcon: Assets.svgsFavNoti,
                    name: subcontractor['name'],
                    isOnline: subcontractor['isOnline'],
                    avatarImage: subcontractor['avatarImage'],
                    description: subcontractor['description'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
