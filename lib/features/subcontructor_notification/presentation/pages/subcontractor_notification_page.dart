part of 'pages.dart';

class SubcontractorNotificationPage extends StatelessWidget {
  SubcontractorNotificationPage({super.key});

  // Sample job data for notifications (replace with actual data source)
  final List<JobHistory> _notificationJobs = [
    const JobHistory(
      title: 'New Job Opportunity',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Available Jobs',
      description:
          'You have a new job request for Carpentry & Farming Services from Jason Rao. Review the details and submit your proposal.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Job request for carpentry and farming services.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesNotificationPerson,
        price: '50',
        rating: 4.0,
      ),
    ),
    const JobHistory(
      title: 'Job Update',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      targetBudget: '\$65.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'Your Active Jobs',
      description:
          'The property manager has reviewed your progress update. Check for any feedback or additional instructions.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Electrician',
        description: 'Progress update reviewed for your ongoing project.',
        name: 'James Michael',
        imageUrl: Assets.imagesWood,
        price: '65',
        rating: 4.0,
      ),
    ),
    // Add more JobHistory items for other notifications as needed
  ];

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
                // Notification item: New Job Opportunity
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomText(
                            text: 'New Job Opportunity',
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
                    const SizedBox(height: 2),
                    const NotificationCard(
                      description:
                          'You have a new job request for Carpentry & Farming Services from Jason Rao. Review the details and submit your proposal.',
                      avatarImage: Assets.imagesNotificationPerson,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the buttons horizontally
                        mainAxisSize: MainAxisSize.min, // Shrink-wrap the Row
                        children: [
                          // Reject Button
                          CustomButton(
                            text: 'REJECT',
                            width: context.responsiveWidth(24),
                            height: context.responsiveHeight(4),
                            color: AppColor.darkBlueShade,
                            textColor: AppColor.white,
                            radius: 25,
                            fontSize: context.responsiveFontSize(8),
                          ),
                          SizedBox(
                              width: context.responsiveWidth(
                                  2)), // Spacing between buttons
                          // Accept Button
                          CustomButton(
                            text: 'ACCEPT',
                            width: context.responsiveWidth(24),
                            height: context.responsiveHeight(4),
                            color: AppColor.mutedGold,
                            textColor: AppColor.white,
                            radius: 25,
                            fontSize: context.responsiveFontSize(8),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: context.responsiveHeight(1)),
                // Notification item: Job Update
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomText(
                            text: 'Job Update',
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
                    const SizedBox(height: 2),
                    const CustomText(
                      text:
                          'The property manager has reviewed your progress update. Check for any feedback or additional instructions.',
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
                  ],
                ),
                SizedBox(height: context.responsiveHeight(2)),
                CustomText(
                  text: '1 Week Ago',
                  color: AppColor.black,
                  fontSize: context.responsiveFontSize(18),
                ),
                SizedBox(height: context.responsiveHeight(2)),
                // Notification item: Proposal Accepted (1 Week Ago)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomText(
                            text: 'Proposal Accepted',
                            fontWeight: FontWeight.w500,
                            fontSize: context.responsiveFontSize(16),
                          ),
                        ),
                        CustomText(
                          text: '1 Week Ago',
                          color: AppColor.midGray,
                          fontSize: context.responsiveFontSize(12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    const NotificationCard(
                      description:
                          'Your proposal for the Carpentry & Farming job has been accepted! The job is now active in your dashboard.',
                      avatarImage: Assets.imagesSubcontractorMichael,
                    ),
                  ],
                ),
                SizedBox(height: context.responsiveHeight(2)),
                // Notification item: Payment Received (1 Week Ago)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomText(
                            text: 'Payment Received',
                            fontWeight: FontWeight.w500,
                            fontSize: context.responsiveFontSize(16),
                          ),
                        ),
                        const CustomText(
                          text: '1 Week Ago',
                          color: AppColor.black,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    const NotificationCard(
                      description:
                          'You\'ve received a payment of \$120.00 for the completed Carpentry job. Funds will be available in your account within 2-3 business days.',
                      avatarImage: Assets.imagesNotificationAvatar,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
