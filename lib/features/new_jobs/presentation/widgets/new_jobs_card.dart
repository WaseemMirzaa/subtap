part of 'widgets.dart';

class NewJobsCard extends StatelessWidget {
  final JobHistory job;
  final VoidCallback? onTap;
  final VoidCallback? onAcceptJob;
  final VoidCallback? onNotInterested;
  final VoidCallback? onBookmark;
  final VoidCallback? onReport;
  final bool isBookmarked;

  const NewJobsCard({
    super.key,
    required this.job,
    this.onTap,
    this.onAcceptJob,
    this.onNotInterested,
    this.onBookmark,
    this.onReport,
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
                    child: (job.svgIcon != null && job.svgIcon!.isNotEmpty)
                        ? SvgPicture.asset(job.svgIcon!, width: 28, height: 24)
                        : const SizedBox(width: 28, height: 24),
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
                              job.title ?? 'No Title',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'HelveticaNeueMedium',
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          // Add status badge here
                        ],
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
                Row(
                  children: [
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
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onBookmark,
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked
                            ? AppColor.mutedGold
                            : AppColor.midGray,
                        size: 20,
                      ),
                    ),
                  ],
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
                child: IntrinsicHeight(
                  // Ensure both sides are vertically aligned
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Vertically center items
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.propertyManagerProfile,
                            arguments: {
                              'propertyManager': job.propertyManager,
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: job.propertyManager?.imageUrl != null
                              ? AssetImage(job.propertyManager!.imageUrl)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Center content
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Posted by  ${job.propertyManager?.name ?? "Unknown"}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (job.propertyManager?.isVerified ==
                                    true) ...[
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
                      Align(
                        alignment: Alignment
                            .center, // Ensure button is centered vertically
                        child: InkWell(
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
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            // Target Budget Row
            Row(
              children: [
                SvgPicture.asset(Assets.svgsTargetBudget,
                    width: 16, height: 16),
                const SizedBox(width: 4),
                RichText(
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
                        text: job.targetBudget ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 14,
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
            const SizedBox(height: 12),
            // Due Date Row
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
                          fontSize: 14,
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                      TextSpan(
                        text: job.dueDate ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 14,
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
            const SizedBox(height: 12),
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
                          text: job.address ?? 'N/A',
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
            // Always show buttons for new jobs (regardless of expiry)
            if (!isActiveJob) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomButton(
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
                          const SizedBox(height: 4),
                          const Text(
                            'No Proposal has been submitted yet',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontFamily: 'HelveticaNeueMedium',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onNotInterested,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.lightGray,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: AppColor.midGray,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onReport,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.lightGray,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.flag,
                            size: 16,
                            color: AppColor.midGray,
                          ),
                        ),
                      ),
                    ],
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
