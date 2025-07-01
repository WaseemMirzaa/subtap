part of 'pages.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  // GetX controller for state management
  final NotificationController _controller = Get.find<NotificationController>();

  // Static list of extras for the notification (same as in SubcontractorNotificationPage)
  final List<Map<String, dynamic>> staticExtras = [
    {
      'description': 'Additional framing for new wall',
      'price': 150.0,
      'timestamp':
          DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
    },
    {
      'description': 'Extra wood for support beams',
      'price': 75.0,
      'timestamp':
          DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
    },
  ];

  // Method to calculate total for the card
  double _calculateTotal() {
    return staticExtras.fold(
        0.0, (sum, item) => sum + (item['price'] as double? ?? 0.0));
  }

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

                    // Add the Extras Requested notification card here
                    Dismissible(
                      key: const Key('extras_requested_notification'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Handle dismissal if needed
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomText(
                                    text: 'Extras Requested',
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
                            SizedBox(height: context.responsiveHeight(1)),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: AppColor.backgroundColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (BuildContext context) {
                                    return ExtrasBottomSheet(
                                      extrasData: staticExtras,
                                      extrasStatus: 'pending',
                                      onClose: () => Navigator.pop(context),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.lightGray, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.orange.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: SvgPicture.asset(
                                            Assets.svgsTime,
                                            width: 16,
                                            height: 16,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Extras Added',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.black,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
                                              ),
                                            ),
                                            Text(
                                              '${staticExtras.length} item(s) - \$${_calculateTotal().toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColor.midGray,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.orange.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.orange
                                                  .withOpacity(0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: const Text(
                                            'Pending',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.orange,
                                              fontFamily: 'HelveticaNeueMedium',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12,
                                          color: AppColor.midGray,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
                                    Get.snackbar(
                                      'Info',
                                      'Extras request rejected',
                                      backgroundColor: Colors.red,
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: AppColor.white,
                                      margin: const EdgeInsets.all(16),
                                      duration: const Duration(seconds: 3),
                                    );
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
                                    Get.snackbar(
                                      'Success',
                                      'Extras request accepted',
                                      backgroundColor: Colors.green,
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: AppColor.white,
                                      margin: const EdgeInsets.all(16),
                                      duration: const Duration(seconds: 3),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: context.responsiveHeight(1)),
                    // Add these after your existing notification items

// Extras Request Accepted notification
                    Dismissible(
                      key: const Key('extras_request_accepted_notification'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Handle dismissal if needed
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomText(
                                    text: 'Extras Request Accepted',
                                    fontWeight: FontWeight.w500,
                                    fontSize: context.responsiveFontSize(16),
                                  ),
                                ),
                                CustomText(
                                  text: '2 Days Ago',
                                  color: AppColor.midGray,
                                  fontSize: context.responsiveFontSize(12),
                                ),
                              ],
                            ),
                            SizedBox(height: context.responsiveHeight(1)),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: AppColor.backgroundColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (BuildContext context) {
                                    return ExtrasBottomSheet(
                                      extrasData: staticExtras,
                                      extrasStatus: 'accepted',
                                      onClose: () => Navigator.pop(context),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.lightGray, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.green.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: SvgPicture.asset(
                                            Assets.svgsTime,
                                            width: 16,
                                            height: 16,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Extras Approved',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.black,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
                                              ),
                                            ),
                                            Text(
                                              '${staticExtras.length} item(s) - \$${_calculateTotal().toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColor.midGray,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.green.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color:
                                                  Colors.green.withOpacity(0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: const Text(
                                            'Accepted',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green,
                                              fontFamily: 'HelveticaNeueMedium',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12,
                                          color: AppColor.midGray,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: context.responsiveHeight(1)),

// Extras Request Cancelled notification
                    Dismissible(
                      key: const Key('extras_request_cancelled_notification'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Handle dismissal if needed
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomText(
                                    text: 'Extras Request Cancelled',
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
                            SizedBox(height: context.responsiveHeight(1)),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: AppColor.backgroundColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (BuildContext context) {
                                    return ExtrasBottomSheet(
                                      extrasData: staticExtras,
                                      extrasStatus: 'cancelled',
                                      onClose: () => Navigator.pop(context),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.lightGray, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: SvgPicture.asset(
                                            Assets.svgsTime,
                                            width: 16,
                                            height: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Extras Cancelled',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.black,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
                                              ),
                                            ),
                                            Text(
                                              '${staticExtras.length} item(s) - \$${_calculateTotal().toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColor.midGray,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color:
                                                  Colors.red.withOpacity(0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: const Text(
                                            'Cancelled',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                              fontFamily: 'HelveticaNeueMedium',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12,
                                          color: AppColor.midGray,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: context.responsiveHeight(1.2)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomButton(
                                  text: 'EDIT',
                                  width: context.responsiveWidth(24),
                                  height: context.responsiveHeight(4),
                                  color: AppColor.darkBlueShade,
                                  textColor: AppColor.white,
                                  radius: 25,
                                  fontSize: context.responsiveFontSize(8),
                                  onTap: () {
                                    Get.snackbar(
                                      'Info',
                                      'Editing extras request',
                                      backgroundColor: Colors.blue,
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: AppColor.white,
                                      margin: const EdgeInsets.all(16),
                                      duration: const Duration(seconds: 3),
                                    );
                                  },
                                ),
                                SizedBox(width: context.responsiveWidth(2)),
                                CustomButton(
                                  text: 'RESUBMIT',
                                  width: context.responsiveWidth(25),
                                  height: context.responsiveHeight(4),
                                  color: AppColor.mutedGold,
                                  textColor: AppColor.white,
                                  radius: 25,
                                  fontSize: context.responsiveFontSize(8),
                                  onTap: () {
                                    Get.snackbar(
                                      'Success',
                                      'Extras request resubmitted',
                                      backgroundColor: Colors.green,
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: AppColor.white,
                                      margin: const EdgeInsets.all(16),
                                      duration: const Duration(seconds: 3),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

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
