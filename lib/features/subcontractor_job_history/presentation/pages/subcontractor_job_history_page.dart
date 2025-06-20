part of 'pages.dart';

class SubcontractorJobHistoryPage extends StatefulWidget {
  const SubcontractorJobHistoryPage({super.key});

  @override
  State<SubcontractorJobHistoryPage> createState() =>
      _SubcontractorJobHistoryPageState();
}

class _SubcontractorJobHistoryPageState
    extends State<SubcontractorJobHistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = 'Open Jobs';
  final List<JobHistory> _allJobs = [
    const JobHistory(
      title: 'General Trades',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Open Jobs',
      description:
          "I hope you're well.I'm looking to get some carpentry & \n Farming work done and wanted to see if you're avaiable.\n Please let me know.",
      subcontractorModel: SubcontractorModel(
        expertise: 'Electrician',
        description:
            'Leaking kitchen sink, Pipe may be cracked. Water  dripping into cabinet below. Happened after  turning on  garbage disposal.',
        name: 'James Michael',
        imageUrl: Assets.imagesSubcontrctorImage,
        price: '50',
        rating: 4.0,
      ),
    ),
    const JobHistory(
      title: 'Electrical & Tech',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'Open Jobs',
      description:
          "I hope you're well.I'm looking to get some carpentry & \n Farming work done and wanted to see if you're avaiable.\n Please let me know.",
      subcontractorModel: SubcontractorModel(
        expertise: 'Electrician',
        description:
            'Leaking kitchen sink, Pipe may be cracked. Water \n dripping into cabinet below. Happened after  turning on  garbage disposal.',
        name: 'James Michael',
        imageUrl: 'path_to_image',
        price: '50',
        rating: 4.0,
      ),
    ),
    const JobHistory(
      title: 'General Trades',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'Active Jobs',
      description:
          "I hope you're well.I'm looking to get some carpentry & \n Farming work done and wanted to see if you're avaiable.\n Please let me know.",
      subcontractorModel: SubcontractorModel(
        expertise: 'Electrician',
        description:
            'Leaking kitchen sink, Pipe may be cracked. Water \n dripping into cabinet below. Happened after  turning on  garbage disposal.',
        name: 'James Michael',
        imageUrl: 'path_to_image',
        price: '50',
        rating: 4.0,
      ),
    ),
    const JobHistory(
      title: 'Electrical & Tech',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'Active Jobs',
      description:
          "I hope you're well.I'm looking to get some carpentry & \n Farming work done and wanted to see if you're avaiable.\n Please let me know.",
      subcontractorModel: SubcontractorModel(
        expertise: 'Electrician',
        description:
            'Leaking kitchen sink, Pipe may be cracked. Water \n dripping into cabinet below. Happened after  turning on  garbage disposal.',
        name: 'James Michael',
        imageUrl: 'path_to_image',
        price: '50',
        rating: 4.0,
      ),
    ),
  ];
  List<JobHistory> _filteredJobs = [];

  @override
  void initState() {
    super.initState();
    _selectedTab =
        (Get.arguments as Map<String, dynamic>?)?['initialTab'] ?? 'Open Jobs';
    _filteredJobs =
        _allJobs.where((job) => job.status == _selectedTab).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _calculateCrossAxisCount(BuildContext context) {
    return MediaQuery.of(context).size.width > 800
        ? 3
        : MediaQuery.of(context).size.width > 600
            ? 2
            : 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SubtapScaffold(
      appBar: const SubcontractorJobHistoryAppbar(),
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.03,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomToggleButton(
                            text: 'Open Jobs',
                            isActive: _selectedTab == 'Open Jobs',
                            onTap: () {
                              setState(() {
                                _selectedTab = 'Open Jobs';
                                _filteredJobs = _allJobs
                                    .where((job) => job.status == 'Open Jobs')
                                    .toList();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomToggleButton(
                            text: 'Active Jobs',
                            isActive: _selectedTab == 'Active Jobs',
                            onTap: () {
                              setState(() {
                                _selectedTab = 'Active Jobs';
                                _filteredJobs = _allJobs
                                    .where((job) => job.status == 'Active Jobs')
                                    .toList();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  _filteredJobs.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'No ${_selectedTab.toLowerCase()} found',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.darkGray,
                              ),
                            ),
                          ),
                        )
                      : MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _filteredJobs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _calculateCrossAxisCount(context),
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio:
                                  _selectedTab == 'Open Jobs' ? 1.57 : 2,
                            ),
                            itemBuilder: (context, index) {
                              return SubcontractorJobHistoryCard(
                                job: _filteredJobs[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SubcontractorJobHistoryDetailPage(
                                        job: _filteredJobs[index],
                                        isOpenJob: _selectedTab == 'Open Jobs',
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
