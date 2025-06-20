part of 'pages.dart';

class FavSubcontractorPage extends StatefulWidget {
  const FavSubcontractorPage({super.key});

  @override
  State<FavSubcontractorPage> createState() => _FavSubcontractorPageState();
}

class _FavSubcontractorPageState extends State<FavSubcontractorPage> {
  final TextEditingController _searchController = TextEditingController();

  // Helper function to show the bottom sheet
  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

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
    {
      'name': 'James Brown',
      'isOnline': true,
      'avatarImage': Assets.imagesFavContractorBrown,
      'description': 'Drywall, Finishing'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      isAppBar: true,
      appBarSecond: const FavSubcontractorAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchBarTile(
                      controller: _searchController,
                      onSearch: () {},
                      hintText: 'Search by Name',
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      showFilterBottomSheet(context);
                    },
                    child: Container(
                      width: 49,
                      height: 49,
                      decoration: BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svgsFilter,
                          width: 19,
                          height: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: subcontractorData.length,
                itemBuilder: (context, index) {
                  final subcontractor = subcontractorData[index];
                  return InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ChatDetailPage(
                    //         userName: subcontractor['name'],
                    //         avatarImage: subcontractor['avatarImage'],
                    //       ),
                    //     ),
                    //   );
                    // },
                    child: FavSubcontractorCard(
                      isFav: false, // No favorite icon
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
      ),
    );
  }
}
