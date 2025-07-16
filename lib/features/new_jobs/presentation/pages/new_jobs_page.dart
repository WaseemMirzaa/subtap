part of 'pages.dart';

class NewJobsPage extends StatelessWidget {
  NewJobsPage({super.key});

  final NewJobsController controller = Get.put(NewJobsController());

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const NewJobsAppbar(),
      body: Column(
        children: [
          // Fixed header with search and filter
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SearchBarTile(
                    controller: controller.searchController,
                    onSearch: () => controller.performSearch(
                      controller.searchController.text,
                    ),
                    hintText: 'Search by name',
                  ),
                ),
                const SizedBox(width: 10),
                GetBuilder<FilterController>(
                  init: FilterController(),
                  builder: (filterController) {
                    final activeFilters = filterController.activeFilterCount;

                    return Stack(
                      children: [
                        InkWell(
                          onTap: () => showFilterBottomSheet(context),
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
                        if (activeFilters > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColor.mutedGold,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                activeFilters.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Scrollable job list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                // Show loading indicator when searching
                if (controller.isSearching.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor.backgroundColor),
                    ),
                  );
                }

                // Show no jobs found message
                if (controller.filteredJobs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'No Jobs Found',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 8),
                        CustomText(
                          text:
                              'Try adjusting filters or updating your skills in profile',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.midGray,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                // Show job list
                return controller.filteredJobs.isEmpty
                    ? const Center(
                        child: Text(
                          'No jobs available',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.midGray,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: controller.filteredJobs.length,
                        itemBuilder: (context, index) {
                          final job = controller.filteredJobs[index];

                          // Add validation before building the card
                          if (job.title == null || job.svgIcon == null) {
                            return const SizedBox.shrink();
                          }

                          return NewJobsCard(
                            job: job,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewJobDetailPage(
                                    job: job,
                                    isNewJob: job.status == 'new Jobs',
                                  ),
                                ),
                              );
                            },
                            onBookmark: () {
                              print('Job bookmarked: ${job.title}');
                            },
                            isBookmarked: false,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
