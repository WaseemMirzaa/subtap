part of 'pages.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const NotificationAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'New Notifications',
                fontWeight: FontWeight.w500,
                fontSize: context.responsiveFontSize(18),
              ),
              SizedBox(height: context.responsiveHeight(2)),

              // Notification item
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          text: 'New Proposal Received',
                          fontWeight: FontWeight.w500,
                          fontSize: context.responsiveFontSize(16),
                        ),
                      ),
                      CustomText(
                        text: '11:23 AM',
                        color: AppColor.midGray,
                        fontSize: context.responsiveFontSize(12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const NotificationCard(
                      description:
                          'Jason Rao send you a new proposal for Carpentry \n & Farming Serices.Please review the details at \n your earlist convenience.',
                      avatarImage: Assets.imagesNotificationPerson),

                  SizedBox(height: context.responsiveHeight(1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          text: 'Progress Update Submitted',
                          fontWeight: FontWeight.w500,
                          fontSize: context.responsiveFontSize(16),
                        ),
                      ),
                      CustomText(
                        text: '11:23 AM',
                        color: AppColor.midGray,
                        fontSize: context.responsiveFontSize(12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const CustomText(
                    text:
                        'A subcontractor has uploaded new progress updates, including notes and/or photos.Please log in to review the latest submission.',
                    maxLines: 3,
                    fontSize: 13,
                    color: AppColor.midGray,
                  ),
                  SizedBox(height: context.responsiveHeight(1.2)),
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
                    ],
                  ),
                  SizedBox(height: context.responsiveHeight(2)),
                  CustomText(
                    text: 'I Week Ago',
                    color: AppColor.black,
                    fontSize: context.responsiveFontSize(18),
                  ),
                  SizedBox(height: context.responsiveHeight(2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          text: 'New Proposal Received',
                          fontWeight: FontWeight.w500,
                          fontSize: context.responsiveFontSize(16),
                        ),
                      ),
                      CustomText(
                        text: 'I Week Ago',
                        color: AppColor.midGray,
                        fontSize: context.responsiveFontSize(12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  const NotificationCard(
                      description:
                          'Jason Rao send you a new proposal for Carpentry \n & Farming Serices.Please review the details at \n your earlist convenience.',
                      avatarImage: Assets.imagesSubcontractorMichael),
                  SizedBox(height: context.responsiveHeight(2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          text: 'New Proposal Received',
                          fontWeight: FontWeight.w500,
                          fontSize: context.responsiveFontSize(16),
                        ),
                      ),
                      CustomText(
                        text: 'I Week Ago',
                        color: AppColor.midGray,
                        fontSize: context.responsiveFontSize(12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  const NotificationCard(
                      description:
                          'Jason Rao send you a new proposal for Carpentry \n & Farming Serices.Please review the details at \n your earlist convenience.',
                      avatarImage: Assets.imagesNotificationAvatar),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
