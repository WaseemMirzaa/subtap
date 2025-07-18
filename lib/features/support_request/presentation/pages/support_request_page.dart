part of 'pages.dart';

class SupportRequestPage extends StatelessWidget {
  const SupportRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupportRequestController());

    return SubtapScaffold(
      appBar: const MySupportAppbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewRequestDialog(context),
        backgroundColor: AppColor.mutedGold,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarTile(
              onSearch: (query) => controller.updateSearchQuery(query),
              hintText: 'Search by order ID, status, or keyword...',
            ),
          ),
          const SizedBox(height: 20),
          // Tabs
          const SupportRequestTabs(),
          const SizedBox(height: 20),
          // Content
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredRequests.isEmpty) {
                return SupportEmptyState(
                  onCreateRequest: () => _showNewRequestDialog(context),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.filteredRequests.length,
                itemBuilder: (context, index) {
                  final request = controller.filteredRequests[index];
                  return EnhancedSupportRequestCard(
                    request: request,
                    onTap: () => _navigateToRequestDetail(context, request),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _navigateToRequestDetail(BuildContext context, SupportRequest request) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SupportDetailPage(
          userName: request.lastUpdatedBy,
          avatarImage: Assets.imagesChatDavid, // Default avatar
        ),
      ),
    );
  }

  void _showNewRequestDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NewRequestBottomSheet(),
    );
  }
}
