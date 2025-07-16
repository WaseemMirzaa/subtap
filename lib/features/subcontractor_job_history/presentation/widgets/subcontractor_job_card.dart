part of 'widgets.dart';

class SubcontractorJobHistoryCard extends StatelessWidget {
  final JobHistory job;
  final VoidCallback? onTap;
  final VoidCallback? onAcceptJob;
  final VoidCallback? onNotInterested;
  final VoidCallback? onBookmark;
  final bool isBookmarked;

  const SubcontractorJobHistoryCard({
    super.key,
    required this.job,
    this.onTap,
    this.onAcceptJob,
    this.onNotInterested,
    this.onBookmark,
    this.isBookmarked = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActiveJob = job.status == 'Active Jobs';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
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
                    child: SvgPicture.asset(job.svgIcon ?? '',
                        width: 28, height: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title ?? '',
                        style: const TextStyle(
                          color: AppColor.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svgsGeneral,
                            width: 14,
                            height: 14,
                          ),
                          const SizedBox(width: 4),
                          const Expanded(
                            child: Text(
                              'Carpentry & Farming',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.midGray,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'HelveticaNeueMedium',
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColor.lightGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        isActiveJob ? Assets.svgsActive : Assets.svgsTime,
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
            const SizedBox(height: 12),
            // Target Budget Row
            Row(
              children: [
                SvgPicture.asset(Assets.svgsTargetBudget,
                    width: 16, height: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Target Budget: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                        TextSpan(
                          text: job.targetBudget,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColor.midGray,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Due Date Row
            Row(
              children: [
                SvgPicture.asset(Assets.svgsDueDate, width: 16, height: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Due Date: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                        TextSpan(
                          text: job.dueDate,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColor.midGray,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Property Manager Section
            if (job.propertyManager != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.offWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage(job.propertyManager!.imageUrl),
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
                                  'Posted by ${job.propertyManager!.name}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (job.propertyManager!.isVerified) ...[
                                const SizedBox(width: 4),
                                SvgPicture.asset(
                                  Assets.svgsVerify,
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              SvgPicture.asset(Assets.svgsStar,
                                  width: 12, height: 12),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '${job.propertyManager!.rating} ★ (${job.propertyManager!.totalJobs} jobs)',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColor.midGray,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatDetailPage(
                              userName: job.propertyManager!.name,
                              avatarImage: job.propertyManager!.imageUrl,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              Assets.svgsChati,
                              width: 14,
                              height: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Message',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            // Address Section
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
                            fontSize: 14,
                            color: AppColor.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                        TextSpan(
                          text: job.address,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColor.midGray,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            // Only show buttons if not an active job
            if (!isActiveJob) ...[
              const SizedBox(height: 16),
              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IntrinsicWidth(
                      child: CustomButton(
                        text: 'Apply Now',
                        onTap: onAcceptJob,
                        color: AppColor.primaryColor,
                        textColor: Colors.white,
                        height: 32,
                        radius: 12,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IntrinsicWidth(
                      child: CustomButton(
                        text: 'Dismiss',
                        onTap: onNotInterested,
                        color: AppColor.lightGray,
                        textColor: AppColor.black,
                        enableBorder: true,
                        borderColor: AppColor.black,
                        height: 32,
                        radius: 12,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
