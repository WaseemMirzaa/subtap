part of 'pages.dart';

class JobVerificationPage extends StatefulWidget {
  final JobHistory job;

  const JobVerificationPage({
    super.key,
    required this.job,
  });

  @override
  State<JobVerificationPage> createState() => _JobVerificationPageState();
}

class _JobVerificationPageState extends State<JobVerificationPage> {
  @override
  void initState() {
    super.initState();
    // Show bottom sheet after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showVerificationBottomSheet();
    });
  }

  void _showVerificationBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.lightGray,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const JobVerificationBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const JobVerificationAppbar(),
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
                                  Assets.svgsActive,
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
                  ),
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ],
      ),
    );
  }
}
