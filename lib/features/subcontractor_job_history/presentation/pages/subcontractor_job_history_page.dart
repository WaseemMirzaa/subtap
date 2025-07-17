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
  var controller = Get.put(SubcontrctorJobHistoryController());

  final List<JobHistory> _allJobs = [
    JobHistory(
      title: 'General Trades',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Open Jobs',
      description:
          "I hope you're well.I'm looking to get some carpentry & farming work done.",
      subcontractorModel: const SubcontractorModel(
        expertise: 'Electrician',
        description: 'Leaking kitchen sink, Pipe may be cracked.',
        name: 'James Michael',
        imageUrl: Assets.imagesSubcontrctorImage,
        price: '50',
        rating: 4.0,
      ),
      propertyManager: const PropertyManagerModel(
        name: 'Jane',
        imageUrl: Assets.imagesHomePerson,
        rating: 4.6,
        totalJobs: 12,
        isVerified: true,
      ),
    ),
    JobHistory(
      title: 'Electrical & Tech',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'Active Jobs',
      description:
          "I hope you're well.I'm looking to get some electrical work done.",
      subcontractorModel: const SubcontractorModel(
        expertise: 'Electrician',
        description: 'Leaking kitchen sink, Pipe may be cracked.',
        name: 'James Michael',
        imageUrl: 'path_to_image',
        price: '50',
        rating: 4.0,
      ),
      propertyManager: const PropertyManagerModel(
        name: 'Jane',
        imageUrl: Assets.imagesHomePerson,
        rating: 4.6,
        totalJobs: 12,
        isVerified: true,
      ),
    ),
    JobHistory(
      title: 'Plumbing Work',
      svgIcon: Assets.svgsTrade,
      price: 80.0,
      targetBudget: '\$80.00',
      dueDate: 'Monday, May 20, 2025',
      address: '789 Pine St, Springfield',
      status: 'Completed',
      description: "Plumbing repair work completed successfully.",
      propertyManager: const PropertyManagerModel(
        name: 'Sarah Johnson',
        imageUrl: Assets.imagesHomePerson,
        rating: 4.8,
        totalJobs: 25,
        isVerified: true,
      ),
      feedback: 'Excellent work! Very professional and completed on time.',
      feedbackRating: 5.0,
    ),
    JobHistory(
      title: 'Electrical Installation',
      svgIcon: Assets.svgsTech,
      price: 120.0,
      targetBudget: '\$120.00',
      dueDate: 'Tuesday, May 21, 2025',
      address: '321 Oak St, Springfield',
      status: 'Declined',
      description: "Electrical installation project.",
      propertyManager: const PropertyManagerModel(
        name: 'Mike Davis',
        imageUrl: Assets.imagesHomePerson,
        rating: 4.2,
        totalJobs: 18,
        isVerified: false,
      ),
    ),
    JobHistory(
      title: 'Carpentry Work',
      svgIcon: Assets.svgsTrade,
      price: 90.0,
      targetBudget: '\$90.00',
      dueDate: 'Wednesday, May 22, 2025',
      address: '654 Elm St, Springfield',
      status: 'Cancelled',
      description: "Carpentry work cancelled due to weather conditions.",
      propertyManager: const PropertyManagerModel(
        name: 'Lisa Brown',
        imageUrl: Assets.imagesHomePerson,
        rating: 4.5,
        totalJobs: 30,
        isVerified: true,
      ),
    ),
  ];

  List<JobHistory> get _filteredJobs {
    if (controller.selectedTab.value == 'Job History') {
      return _allJobs
          .where((job) =>
              job.status == 'Completed' ||
              job.status == 'Declined' ||
              job.status == 'Cancelled')
          .toList();
    }
    return _allJobs
        .where((job) => job.status == controller.selectedTab.value)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    print('callingfssss');
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
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.035,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      Obx(
                        () => _filteredJobs.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'No ${controller.selectedTab.value.toLowerCase()} found',
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
                                    crossAxisCount:
                                        _calculateCrossAxisCount(context),
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: controller
                                                .selectedTab.value ==
                                            'Open Jobs'
                                        ? 1.1 // Open jobs have buttons, so need more height
                                        : controller.selectedTab.value ==
                                                'Job History'
                                            ? 0.87 // Job history has no buttons, just status badge and feedback
                                            : 1.39,
                                    // Active jobs have no buttons either
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
                                              isOpenJob: controller
                                                      .selectedTab.value ==
                                                  'Open Jobs',
                                            ),
                                          ),
                                        );
                                      },
                                      onBookmark:
                                          controller.selectedTab.value ==
                                                  'Open Jobs'
                                              ? () {
                                                  print(
                                                      'Job bookmarked: ${_filteredJobs[index].title}');
                                                }
                                              : null,
                                      isBookmarked: false,
                                    );
                                  },
                                ),
                              ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 8,
                  right: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(() => Row(
                            children: [
                              Expanded(
                                child: CustomToggleButton(
                                  text: 'Invited Jobs',
                                  isActive: controller.selectedTab.value ==
                                      'Open Jobs',
                                  onTap: () =>
                                      controller.changeTab('Open Jobs'),
                                ),
                              ),
                              Expanded(
                                child: CustomToggleButton(
                                  text: 'In Progress',
                                  isActive: controller.selectedTab.value ==
                                      'Active Jobs',
                                  onTap: () =>
                                      controller.changeTab('Active Jobs'),
                                ),
                              ),
                              Expanded(
                                child: CustomToggleButton(
                                  text: 'Job History',
                                  isActive: controller.selectedTab.value ==
                                      'Job History',
                                  onTap: () =>
                                      controller.changeTab('Job History'),
                                ),
                              ),
                            ],
                          )),
                    ),
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
