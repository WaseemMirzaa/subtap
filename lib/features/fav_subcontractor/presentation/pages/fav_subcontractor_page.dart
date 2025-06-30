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
    final screenSize = MediaQuery.of(context).size;

    return SubtapScaffold(
      isAppBar: true,
      appBarSecond: const FavSubcontractorAppbar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenSize.width > 800
                  ? 1200
                  : screenSize.width > 600
                      ? 800
                      : screenSize.width * 0.99,
              minHeight: screenSize.height,
            ),
            child: Stack(
              children: [
                // Scrollable content
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        // Add padding to avoid overlap with search bar and filter button
                        const SizedBox(
                            height: 90), // Adjust based on search bar height
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: subcontractorData.length,
                          itemBuilder: (context, index) {
                            final subcontractor = subcontractorData[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.favSubcontractorProfile,
                                  arguments: {
                                    'subcontractor': subcontractor,
                                  },
                                );
                              },
                              child: FavSubcontractorCard(
                                isFav: false,
                                favIcon: Assets.svgsFavNoti,
                                name: subcontractor['name'],
                                isOnline: subcontractor['isOnline'],
                                avatarImage: subcontractor['avatarImage'],
                                description: subcontractor['description'],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Search bar and filter button fixed at the top
                Positioned(
                  top: 20, // Gap between AppBar and search bar
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchBarTile(
                          controller: _searchController,
                          onSearch: () {},
                          hintText: 'Search by name',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
