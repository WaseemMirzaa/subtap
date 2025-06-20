part of 'widgets.dart';

class SubcontractorJobCard extends StatelessWidget {
  final SubcontractorModel subcontractor;
  final VoidCallback? onTap;
  final bool showActionButtons;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const SubcontractorJobCard({
    super.key,
    required this.subcontractor,
    this.onTap,
    this.showActionButtons = false,
    this.onAccept,
    this.onReject,
  });

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
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      Assets.imagesSubcontrctorImage,
                      width: 28,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subcontractor.name,
                        style: const TextStyle(
                          color: AppColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const CustomText(
                            text: 'Expertise: ',
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              subcontractor.expertise,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColor.midGray,
                                fontWeight: FontWeight.w400,
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
                const SizedBox(width: 7),
                Container(
                  width: 45,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColor.offWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.svgsStar,
                        width: 10,
                        height: 10,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subcontractor.rating.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColor.mutedGold,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SvgPicture.asset(Assets.svgsTargetBudget,
                    width: 16, height: 16),
                const SizedBox(width: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Budget: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: subcontractor.price.isEmpty
                            ? 'Not specified'
                            : '\$${subcontractor.price}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.midGray,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    subcontractor.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.midGray,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Action buttons (conditionally shown)
            if (showActionButtons) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IntrinsicWidth(
                      child: CustomButton(
                        text: 'ACCEPT OFFER',
                        onTap: onReject,
                        color: AppColor.mutedGold,
                        textColor: AppColor.white,
                        enableBorder: true,
                        height: 32,
                        radius: 14,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IntrinsicWidth(
                      child: CustomButton(
                        text: 'REJECT',
                        onTap: onAccept,
                        color: AppColor.darkBlue,
                        textColor: AppColor.white,
                        height: 32,
                        radius: 14,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
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
