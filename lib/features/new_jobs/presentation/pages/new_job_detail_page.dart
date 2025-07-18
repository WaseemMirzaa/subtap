part of 'pages.dart';

class NewJobDetailPage extends StatefulWidget {
  final JobHistory job;
  final bool isNewJob;

  const NewJobDetailPage({
    super.key,
    required this.job,
    required this.isNewJob,
  });

  @override
  State<NewJobDetailPage> createState() => _NewJobDetailPageState();
}

class _NewJobDetailPageState extends State<NewJobDetailPage> {
  late NewJobDetailController detailController;

  @override
  void initState() {
    super.initState();
    detailController = Get.put(NewJobDetailController());
    detailController.checkJobExpiry(widget.job.dueDate, widget.job.urgencyTag);
  }

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const NewJobsDetailAppbar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Property Manager Info
                      PropertyManagerInfo(
                        propertyManager: widget.job.propertyManager,
                        onMessageTap: () {
                          // Navigate to chat
                        },
                      ),
                      const SizedBox(height: 16),

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
                                widget.job.svgIcon ?? '',
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.job.title ?? 'No Title',
                                        style: const TextStyle(
                                          color: AppColor.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'HelveticaNeueMedium',
                                        ),
                                      ),
                                    ),
                                    JobStatusBadge(
                                      dueDate: widget.job.dueDate,
                                      status: widget.job.status,
                                      urgencyTag: widget.job
                                          .urgencyTag, // Pass the urgencyTag
                                    ),
                                  ],
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
                                    const Flexible(
                                      child: Text(
                                        'Carpentry & Framing',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'HelveticaNeueMedium',
                                          color: AppColor.midGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Job details with distance
                      _buildJobDetails(),

                      const SizedBox(height: 20),

                      // Description
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
                        detailController
                            .formatDescription(widget.job.description),
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColor.midGray,
                          fontFamily: 'HelveticaNeueMedium',
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Images
                      _buildJobImages(),

                      const SizedBox(height: 20),

                      // Job Actions
                      Obx(() => JobActionsWidget(
                            jobTitle: widget.job.title ?? '',
                            jobId: '#${widget.job.title?.hashCode ?? 0}',
                            isBookmarked: detailController.isBookmarked.value,
                            onBookmarkTap: detailController.toggleBookmark,
                          )),
                    ],
                  ),
                ),
              ),
              if (widget.isNewJob || widget.job.status == 'new Jobs')
                const SizedBox(height: 120),
            ],
          ),
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

  Widget _buildJobDetails() {
    return Column(
      children: [
        // Target Budget
        Row(
          children: [
            SvgPicture.asset(Assets.svgsTargetBudget, width: 16, height: 16),
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
                    text: widget.job.targetBudget ?? 'N/A',
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
        const SizedBox(height: 10),

        // Due Date
        Row(
          children: [
            SvgPicture.asset(Assets.svgsDueDate, width: 16, height: 16),
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
                    text: widget.job.dueDate ?? 'N/A',
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
        const SizedBox(height: 10),

        // Address
        Row(
          children: [
            SvgPicture.asset(Assets.svgsLocation, width: 16, height: 16),
            const SizedBox(width: 4),
            Expanded(
              child: RichText(
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
                      text: widget.job.address ?? 'N/A',
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
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Distance
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: DistanceWidget(address: widget.job.address),
        ),
      ],
    );
  }

  Widget _buildJobImages() {
    return Row(
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
        const SizedBox(width: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            Assets.imagesWoodie,
            width: 70,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
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
    );
  }

  Widget _buildBottomActionBar() {
    return Obx(() {
      final isExpired = detailController.isJobExpired.value;

      if (widget.isNewJob) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: isExpired
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This job is no longer accepting applicants.',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomButton(
                          text: 'Apply Now',
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.subcontractorJob,
                              arguments: {'isFromAcceptJob': true},
                            );
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
                          text: 'Dismiss',
                          onTap: () {
                            Navigator.pop(context);
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
      }
      return const SizedBox.shrink();
    });
  }
}
