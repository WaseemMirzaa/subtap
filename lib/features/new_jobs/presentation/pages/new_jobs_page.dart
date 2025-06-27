part of 'pages.dart';

class NewJobsPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
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
      title: 'General Trades',
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
  ];

  NewJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const NewJobsAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              SearchBarTile(
                controller: _searchController,
                onSearch: () {},
                hintText: 'Search by name',
              ),
              const SizedBox(height: 15),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _allJobs.length,
                itemBuilder: (context, index) {
                  final job = _allJobs[index];
                  return NewJobsCard(
                    job: job,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewJobDetailPage(
                            job: job,
                            isOpenJob: job.status == 'Open Jobs',
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
