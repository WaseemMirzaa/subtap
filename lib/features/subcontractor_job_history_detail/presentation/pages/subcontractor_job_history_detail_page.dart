part of 'pages.dart';

class SubcontractorJobHistoryDetailPage extends StatefulWidget {
  final JobHistory job;
  final bool isOpenJob;

  const SubcontractorJobHistoryDetailPage({
    super.key,
    required this.job,
    required this.isOpenJob,
  });

  @override
  State<SubcontractorJobHistoryDetailPage> createState() =>
      _SubcontractorJobHistoryDetailPageState();
}

class _SubcontractorJobHistoryDetailPageState
    extends State<SubcontractorJobHistoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const SubcontractorJobHistoryAppbar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      // Job title, price, and status row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColor.offWhite,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                widget.job.svgIcon,
                                width: 28,
                                height: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.job.title,
                                  style: const TextStyle(
                                    color: AppColor.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.svgsGeneral,
                                      width: 16,
                                      height: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Carpentry & Framing ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
                                                color: AppColor.midGray,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 100),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  widget.job.status == 'Active Jobs'
                                      ? Assets.svgsActive
                                      : Assets.svgsTime,
                                  width: 14,
                                  height: 14,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Preferred Time
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svgsTargetBudget,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Target Budget: ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                                TextSpan(
                                  text: widget.job.targetBudget,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColor.midGray,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      kGap10,
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svgsDueDate,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Due Date: ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                                TextSpan(
                                  text: widget.job.dueDate,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColor.midGray,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      kGap10,
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svgsLocation,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Address: ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                                TextSpan(
                                  text: widget.job.address,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColor.midGray,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      kGap20,
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.job.description ?? 'No description available',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColor.midGray,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Assets.imagesWood,
                              width: 70,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          kGap10,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Assets.imagesWoodie,
                              width: 70,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          kGap10,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Assets.imagesSideWood,
                              width: 70,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      kGap20,
                      if (widget.job.status == 'Active Jobs') ...[
                        const Text(
                          'Status:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const StatusTimeline(
                          statuses: [
                            {
                              'status': 'Assigned',
                              'isCompleted': true,
                              'date': '2:00pm - May 21, 2025'
                            },
                            {
                              'status': 'In Progress',
                              'isCompleted': true,
                              'date': '2:00pm - May 22, 2025'
                            },
                            {
                              'status': 'Completed',
                              'isCompleted': true,
                              'date': '2:00pm - May 22, 2025'
                            },
                          ],
                        ),
                        kGap20,
                      ],
                    ],
                  ),
                ),
              ),
              // Add empty container to prevent bottom overflow when action bar is visible
              if (widget.isOpenJob || widget.job.status == 'Active Jobs')
                const SizedBox(
                    height:
                        120), // Increased height to ensure action bar visibility
            ],
          ),
          // Bottom action bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomActionBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    print(
        'Job Status: ${widget.job.status}, isOpenJob: ${widget.isOpenJob}'); // Debug print
    if (widget.isOpenJob) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomButton(
                  text: 'Accept Jobs',
                  onTap: () {
                    Get.toNamed(AppRoutes.subcontractorJob);
                  },
                  color: AppColor.mutedGold,
                  textColor: Colors.white,
                  fontWeight: FontWeight.w400,
                  radius: 17,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomButton(
                  text: 'Not Interested',
                  onTap: () {
                    // Handle not interested
                  },
                  color: AppColor.white,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w400,
                  radius: 17,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (widget.job.status == 'Active Jobs') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            CustomButton(
              text: 'Upload Progress',
              onTap: () {
                Get.toNamed(AppRoutes.uploadProgress);
              },
              color: AppColor.mutedGold,
              textColor: Colors.white,
              fontWeight: FontWeight.w400,
              radius: 14,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.mediationProcess);
              },
              child: const Text(
                'Mediation Process',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'HelveticaNeueMedium',
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink(); // Return empty widget for other statuses
    }
  }
}
