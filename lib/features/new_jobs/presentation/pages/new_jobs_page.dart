part of 'pages.dart';

class NewJobsPage extends StatelessWidget {
  NewJobsPage({super.key});

  final NewJobsController controller = Get.put(NewJobsController());
  final FilterController filterController = Get.put(FilterController());

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
                    onSearch: (query) => controller.performSearch(query),
                    hintText: 'Search by name',
                  ),
                ),
                const SizedBox(width: 10),
                Obx(() {
                  final activeFilters = filterController.activeFilterCount;

                  return Stack(
                    children: [
                      // Filter icon with gold background when filters are active
                      InkWell(
                        onTap: () => showFilterBottomSheet(context),
                        child: Container(
                          width: 49,
                          height: 49,
                          decoration: BoxDecoration(
                            color: activeFilters > 0
                                ? AppColor.mutedGold.withOpacity(0.1)
                                : AppColor.backgroundColor,
                            borderRadius: BorderRadius.circular(14),
                            border: activeFilters > 0
                                ? Border.all(
                                    color: AppColor.mutedGold, width: 1)
                                : null,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svgsFilter,
                              width: 19,
                              height: 19,
                              color: activeFilters > 0
                                  ? AppColor.mutedGold
                                  : AppColor.white,
                            ),
                          ),
                        ),
                      ),
                      // Badge for active filter count
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
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '$activeFilters',
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
                }),
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
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  itemCount: controller.filteredJobs.length,
                  itemBuilder: (context, index) {
                    final job = controller.filteredJobs[index];

                    if (job.title == null || job.svgIcon == null) {
                      return const SizedBox.shrink();
                    }

                    return Dismissible(
                      key: Key('job_${job.title}_$index'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.only(
                            bottom: 20, left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete_outline,
                                color: Colors.white, size: 24),
                            SizedBox(height: 4),
                            Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (direction) {
                        controller.removeJob(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${job.title} removed'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                controller.undoRemoveJob(job, index);
                              },
                            ),
                          ),
                        );
                      },
                      child: ImprovedJobCard(
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
                        onAcceptJob: () {
                          Get.toNamed(
                            AppRoutes.subcontractorJob,
                            arguments: {'isFromAcceptJob': true},
                          );
                        },
                        onBookmark: () {
                          print('Job bookmarked: ${job.title}');
                        },
                        onNotInterested: () {
                          print('Not interested: ${job.title}');
                        },
                        onReport: () {
                          print('Report job: ${job.title}');
                        },
                        isBookmarked: false,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
