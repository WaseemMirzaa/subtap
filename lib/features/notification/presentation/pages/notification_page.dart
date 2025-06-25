part of 'pages.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  // Sample job data for notifications (replace with actual data source)
  final List<JobHistory> _notificationJobs = [
    const JobHistory(
      title: 'New Proposal Received',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Requested Jobs',
      description:
          'Jason Rao sent you a new proposal for Carpentry & Farming Services. Please review the details at your earliest convenience.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Proposal for carpentry and farming services.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesNotificationPerson,
        price: '50',
        rating: 4.0,
      ),
    ),
    const JobHistory(
      title: 'Progress Update Submitted',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      targetBudget: '\$65.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'Active Jobs',
      description:
          'A subcontractor has uploaded new progress updates, including notes and/or photos. Please log in to review the latest submission.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Electrician',
        description: 'Progress update for ongoing project.',
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
                // Notification item: New Proposal Received
                InkWell(
                  onTap: () {
                    // Navigate to JobHistoryDetailPage for Requested Jobs
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobHistoryDetailPage(
                          job:
                              _notificationJobs[0], // New Proposal Received job
                          isRequestedJob: true,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 2),
                      const NotificationCard(
                        description:
                            'Jason Rao sent you a new proposal for Carpentry & Farming Services. Please review the details at your earliest convenience.',
                        avatarImage: Assets.imagesNotificationPerson,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.responsiveHeight(1)),
                // Notification item: Progress Update Submitted
                InkWell(
                  onTap: () {
                    // Navigate to JobHistoryDetailPage for Active Jobs
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobHistoryDetailPage(
                          job: _notificationJobs[
                              1], // Progress Update Submitted job
                          isRequestedJob: false,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 2),
                      const CustomText(
                        text:
                            'A subcontractor has uploaded new progress updates, including notes and/or photos. Please log in to review the latest submission.',
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
                ),
                SizedBox(height: context.responsiveHeight(2)),
                CustomText(
                  text: '1 Week Ago',
                  color: AppColor.black,
                  fontSize: context.responsiveFontSize(18),
                ),
                SizedBox(height: context.responsiveHeight(2)),
                // Notification item: New Proposal Received (1 Week Ago)
                InkWell(
                  onTap: () {
                    // Navigate to JobHistoryDetailPage for Requested Jobs
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobHistoryDetailPage(
                          job: _notificationJobs[
                              0], // Reusing New Proposal Received job
                          isRequestedJob: true,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            text: '1 Week Ago',
                            color: AppColor.midGray,
                            fontSize: context.responsiveFontSize(12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 1),
                      const NotificationCard(
                        description:
                            'Jason Rao sent you a new proposal for Carpentry & Farming Services. Please review the details at your earliest convenience.',
                        avatarImage: Assets.imagesSubcontractorMichael,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.responsiveHeight(2)),
                // Notification item: New Proposal Received (1 Week Ago)
                InkWell(
                  onTap: () {
                    // Navigate to JobHistoryDetailPage for Requested Jobs
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobHistoryDetailPage(
                          job: _notificationJobs[
                              0], // Reusing New Proposal Received job
                          isRequestedJob: true,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            'Jason Rao sent you a new proposal for Carpentry & Farming Services. Please review the details at your earliest convenience.',
                        avatarImage: Assets.imagesNotificationAvatar,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
