part of 'pages.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  // GetX controller for state management
  final NotificationController _controller = Get.find<NotificationController>();

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
                    // New Notifications
                    ..._controller.notificationJobs
                        .asMap()
                        .entries
                        .map((entry) {
                      int index = entry.key;
                      var job = entry.value;
                      return Column(
                        children: [
                          Dismissible(
                            key: Key('notification_$index${job.title}'),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              _controller.removeNotification(index);
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobHistoryDetailPage(
                                      job: job,
                                      isRequestedJob: index == 0,
                                    ),
                                  ),
                                );
                              },
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
                                            text: index == 0
                                                ? 'New Proposal Received'
                                                : 'Progress Update Submitted',
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                context.responsiveFontSize(16),
                                          ),
                                        ),
                                        CustomText(
                                          text: '11:23 AM',
                                          color: AppColor.midGray,
                                          fontSize:
                                              context.responsiveFontSize(12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    if (index == 0)
                                      const NotificationCard(
                                        description:
                                            'Jason Rao sent you a new proposal for Carpentry & Farming Services. Please review the details at your earliest convenience.',
                                        avatarImage:
                                            Assets.imagesNotificationPerson,
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const CustomText(
                                            text:
                                                'A subcontractor has uploaded new progress updates, including notes and/or photos. Please log in to review the latest submission.',
                                            maxLines: 3,
                                            fontSize: 13,
                                            color: AppColor.midGray,
                                          ),
                                          SizedBox(
                                              height: context
                                                  .responsiveHeight(1.2)),
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.asset(
                                                  Assets.imagesWood,
                                                  width: 70,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: context.responsiveHeight(1)),
                        ],
                      );
                    }).toList(),
                    // Older Notifications (1 Week Ago)
                    if (_controller.notificationJobs.isNotEmpty) ...[
                      SizedBox(height: context.responsiveHeight(2)),
                      CustomText(
                        text: '1 Week Ago',
                        color: AppColor.black,
                        fontSize: context.responsiveFontSize(18),
                      ),
                      SizedBox(height: context.responsiveHeight(2)),
                      ..._controller.notificationJobs
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        var job = entry.value;
                        return Column(
                          children: [
                            Dismissible(
                              key: Key('old_notification_$index${job.title}'),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                _controller.removeNotification(index);
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          JobHistoryDetailPage(
                                        job: job,
                                        isRequestedJob: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: CustomText(
                                              text: 'New Proposal Received',
                                              fontWeight: FontWeight.w500,
                                              fontSize: context
                                                  .responsiveFontSize(16),
                                            ),
                                          ),
                                          CustomText(
                                            text: '1 Week Ago',
                                            color: AppColor.midGray,
                                            fontSize:
                                                context.responsiveFontSize(12),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 1),
                                      NotificationCard(
                                        description:
                                            'Jason Rao sent you a new proposal for Carpentry & Farming Services. Please review the details at your earliest convenience.',
                                        avatarImage: index == 0
                                            ? Assets.imagesSubcontractorMichael
                                            : Assets.imagesNotificationAvatar,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: context.responsiveHeight(1)),
                          ],
                        );
                      }).toList(),
                    ],
                  ],
                ],
              )),
        ),
      ),
    );
  }
}
