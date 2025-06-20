part of 'pages.dart';

class SubcontractorHomePage extends StatefulWidget {
  const SubcontractorHomePage({super.key});

  @override
  State<SubcontractorHomePage> createState() => _SubcontractorHomePageState();
}

class _SubcontractorHomePageState extends State<SubcontractorHomePage> {
  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      isAppBar: true,
      appBarSecond: const SubcontractorHomeAppbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const JobStatusCard(
                  firstTitle: 'In Progress',
                  firstValue: '03',
                  secondTitle: 'Awaiting Code',
                  secondValue: '01',
                  thirdTitle: 'Completed',
                  thirdValue: '27',
                ),
                kGap20,
                const CustomText(
                  text: 'Quick Actions',
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                kGap10,
                Container(
                  width: double.infinity, // Match parent width
                  padding: const EdgeInsets.all(
                      8), // Same padding as AppBar container
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(10)), // Rounded edges
                  ),
                  child: Column(
                    children: [
                      ActionCard(
                        svgAssetPath:
                            Assets.svgsUploadProgress, // Example SVG asset
                        actionText: 'Upload Progress',
                        onTap: () {
                          Get.toNamed(AppRoutes.uploadProgress);
                        },
                      ),
                      ActionCard(
                        svgAssetPath:
                            Assets.svgsSubmitProposal, // Example SVG asset
                        actionText: 'Submit Proposal',
                        onTap: () {
                          Get.toNamed(
                            AppRoutes
                                .subcontractorJobHistory, // Make sure you have this route defined
                            arguments: {
                              'initialTab': 'Active Jobs'
                            }, // Pass the tab you want to show
                          );
                        },
                      ),
                      ActionCard(
                        svgAssetPath: Assets.svgsOpenJobs, // Example SVG asset
                        actionText: 'Open Jobs',
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.subcontractorJobHistory,
                            arguments: {
                              'initialTab': 'Open Jobs'
                            }, // Pass the tab you want to show
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Add more content to make it visible
              ],
            ),
          ),
        ],
      ),
    );
  }
}
