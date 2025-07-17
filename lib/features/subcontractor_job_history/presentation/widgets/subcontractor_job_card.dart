part of 'widgets.dart';

class SubcontractorJobHistoryCard extends StatelessWidget {
  final JobHistory job;
  final VoidCallback? onTap;
  final VoidCallback? onAcceptJob;
  final VoidCallback? onNotInterested;
  final VoidCallback? onBookmark;
  final bool isBookmarked;
  final VoidCallback? onReport;

  const SubcontractorJobHistoryCard({
    super.key,
    required this.job,
    this.onTap,
    this.onAcceptJob,
    this.onNotInterested,
    this.onBookmark,
    this.isBookmarked = false,
    this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActiveJob = job.status == 'Active Jobs';
    final bool isHistoryJob = job.status == 'Completed' ||
        job.status == 'Declined' ||
        job.status == 'Cancelled';

    return IntrinsicHeight(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status badge for history jobs
              if (isHistoryJob) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(job.status!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    job.status!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
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
                      // Bookmark button
                      InkWell(
                        onTap: onBookmark,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColor.lightGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            Assets.svgsBookmark,
                            width: 16,
                            height: 16,
                            color: isBookmarked
                                ? AppColor.mutedGold
                                : AppColor.midGray,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Report button
                      InkWell(
                        onTap: onReport,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColor.lightGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.flag_outlined,
                            size: 16,
                            color: AppColor.midGray,
                          ),
                        ),
                      ),
                    ],
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
                          backgroundImage:
                              AssetImage(job.propertyManager!.imageUrl),
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
              // Only show buttons if it's an Open Job (not Active Job or Job History)
              if (job.status == 'Open Jobs') ...[
                const SizedBox(height: 16),
                // Buttons Row
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
              // Feedback section for completed jobs
              if (job.status == 'Completed' && job.feedback != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.offWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Property Manager Feedback:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                            ),
                          ),
                          const Spacer(),
                          if (job.feedbackRating != null) ...[
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 16,
                                  color: index < job.feedbackRating!
                                      ? Colors.amber
                                      : Colors.grey[300],
                                );
                              }),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        job.feedback!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.midGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Declined':
        return Colors.red;
      case 'Cancelled':
        return Colors.orange;
      default:
        return AppColor.midGray;
    }
  }
}
