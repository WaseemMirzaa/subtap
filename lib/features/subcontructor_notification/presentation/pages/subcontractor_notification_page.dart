part of 'pages.dart';

class SubcontractorNotificationPage extends StatelessWidget {
  SubcontractorNotificationPage({super.key});

  // GetX controller for state management
  final SubcontractorNotificationController _controller =
      Get.find<SubcontractorNotificationController>();

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const NotificationAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'New Notifications',
                    fontWeight: FontWeight.w500,
                    fontSize: context.responsiveFontSize(18),
                  ),
                  SizedBox(height: context.responsiveHeight(2)),
                  // Check if there are no notifications
                  if (_controller.notificationJobs.isEmpty)
                    Center(
                      child: CustomText(
                        text: 'No notifications found',
                        fontWeight: FontWeight.w400,
                        fontSize: context.responsiveFontSize(16),
                        color: AppColor.midGray,
                      ),
                    )
                  else ...[
                    // Notification item: New Job Opportunity
                    if (_controller.notificationJobs.isNotEmpty)
                      Dismissible(
                        key: Key(
                            'new_job_0_${_controller.notificationJobs[0].title}'),
                        direction:
                            DismissDirection.endToStart, // Swipe from left
                        onDismissed: (direction) {
                          _controller.removeNotification(0);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              CustomText(
                                text: 'Delete',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              SizedBox(height: context.responsiveHeight(1.2)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomButton(
                                    text: 'REJECT',
                                    width: context.responsiveWidth(24),
                                    height: context.responsiveHeight(4),
                                    color: AppColor.darkBlueShade,
                                    textColor: AppColor.white,
                                    radius: 25,
                                    fontSize: context.responsiveFontSize(8),
                                    onTap: () {
                                      // Handle REJECT action (e.g., call API or update state)
                                    },
                                  ),
                                  SizedBox(width: context.responsiveWidth(2)),
                                  CustomButton(
                                    text: 'ACCEPT',
                                    width: context.responsiveWidth(24),
                                    height: context.responsiveHeight(4),
                                    color: AppColor.mutedGold,
                                    textColor: AppColor.white,
                                    radius: 25,
                                    fontSize: context.responsiveFontSize(8),
                                    onTap: () {
                                      // Handle ACCEPT action (e.g., call API or update state)
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: context.responsiveHeight(1)),
                    // Notification item: Job Update
                    if (_controller.notificationJobs.length > 1)
                      Dismissible(
                        key: Key(
                            'job_update_1_${_controller.notificationJobs[1].title}'),
                        direction:
                            DismissDirection.startToEnd, // Swipe from left
                        onDismissed: (direction) {
                          _controller.removeNotification(1);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              CustomText(
                                text: 'Delete',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        ),
                      ),
                    SizedBox(height: context.responsiveHeight(2)),
                    CustomText(
                      text: '1 Week Ago',
                      color: AppColor.black,
                      fontSize: context.responsiveFontSize(18),
                    ),
                    SizedBox(height: context.responsiveHeight(2)),
                    // Notification item: Proposal Accepted (1 Week Ago)
                    if (_controller.notificationJobs.length > 2)
                      Dismissible(
                        key: Key(
                            'proposal_accepted_2_${_controller.notificationJobs[2].title}'),
                        direction:
                            DismissDirection.startToEnd, // Swipe from left
                        onDismissed: (direction) {
                          _controller.removeNotification(2);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              CustomText(
                                text: 'Delete',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        ),
                      ),
                    SizedBox(height: context.responsiveHeight(2)),
                    // Notification item: Payment Received (1 Week Ago)
                    if (_controller.notificationJobs.length > 3)
                      Dismissible(
                        key: Key(
                            'payment_received_3_${_controller.notificationJobs[3].title}'),
                        direction:
                            DismissDirection.startToEnd, // Swipe from left
                        onDismissed: (direction) {
                          _controller.removeNotification(3);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              CustomText(
                                text: 'Delete',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: CustomText(
                                      text: 'Payment Received',
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
                                    'You\'ve received a payment of \$120.00 for the completed Carpentry job. Funds will be available in your account within 2-3 business days.',
                                avatarImage: Assets.imagesNotificationAvatar,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ],
              )),
        ),
      ),
    );
  }
}
