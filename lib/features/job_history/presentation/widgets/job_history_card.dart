part of 'widgets.dart';

class JobHistoryCard extends StatelessWidget {
  final JobHistory job;
  final VoidCallback? onTap;

  const JobHistoryCard({super.key, required this.job, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.offWhite,
                    borderRadius: BorderRadius.circular(14), // Oval shape
                  ),
                  child: Center(
                    child: SvgPicture.asset(job.svgIcon, width: 28, height: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(
                          color: AppColor.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
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
                              'Carpentry & Framing',
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
                    borderRadius: BorderRadius.circular(10), // Oval shape
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        job.status == 'Active Jobs'
                            ? Assets.svgsActive
                            : Assets.svgsTime,
                        width: 14,
                        height: 14,
                        fit: BoxFit.contain, // Add this to ensure proper sizing
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
                        text: job
                            .targetBudget, // Assuming this field can be reused
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
                        text: job
                            .dueDate, // Assuming JobHistory has a dueDate field
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
                RichText(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
