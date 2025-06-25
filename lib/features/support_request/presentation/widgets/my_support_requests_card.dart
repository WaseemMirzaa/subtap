part of 'widgets.dart';

class MySupportRequestsCard extends StatelessWidget {
  final String status;
  final VoidCallback? onTap;

  const MySupportRequestsCard({
    super.key,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.lightGray,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        status == 'In Progress'
                            ? Assets.svgsTime
                            : Assets.svgsCheckbox,
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'I need assistance with my cancelled order',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'HelveticaNeueMedium',
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: '- Order #FO52072C9E905',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaNeueMedium',
                    ),
                  ],
                ),
                kGap10,
                CustomText(
                  text: 'Id# 12917150',
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'HelveticaNeueMedium',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
