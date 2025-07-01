part of 'pages.dart';

class SubcontractorNotificationPage extends StatelessWidget {
  SubcontractorNotificationPage({super.key});

  // GetX controller for state management
  final SubcontractorNotificationController _controller =
      Get.find<SubcontractorNotificationController>();

  // Static list of extras for the notification
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
    print('notificationJobs length: ${_controller.notificationJobs.length}');
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
                    // Notification item: Extras Requested (1 Week Ago)
                    if (_controller.notificationJobs.length > 3)
                      Dismissible(
                        key: Key(
                            'extras_requested_3_${_controller.notificationJobs[3].title}'),
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
                              Obx(() => GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor:
                                            AppColor.backgroundColor,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        builder: (BuildContext context) {
                                          return ExtrasBottomSheet(
                                            extrasData: staticExtras,
                                            extrasStatus: 'pending',
                                            onClose: () =>
                                                Navigator.pop(context),
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
                                            color: AppColor.lightGray,
                                            width: 1),
                                      ),
                                      child: _controller.isSubmitting.value
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.orange),
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6),
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Extras Added',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                AppColor.black,
                                                            fontFamily:
                                                                'HelveticaNeueMedium',
                                                          ),
                                                        ),
                                                        Text(
                                                          '${staticExtras.length} item(s) - \$${_calculateTotal().toStringAsFixed(2)}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: AppColor
                                                                .midGray,
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 12,
                                                        vertical: 6,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
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
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.orange,
                                                          fontFamily:
                                                              'HelveticaNeueMedium',
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
                                  )),
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

                    // Add these after the existing notification cards in your Column children:

                    SizedBox(height: context.responsiveHeight(2)),
// Notification item: Extras Request Accepted (2 Weeks Ago)
                    if (_controller.notificationJobs.length > 4)
                      Dismissible(
                        key: Key(
                            'extras_accepted_4_${_controller.notificationJobs[4].title}'),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          _controller.removeNotification(4);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white),
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
                                      text: 'Extras Request Accepted',
                                      fontWeight: FontWeight.w500,
                                      fontSize: context.responsiveFontSize(16),
                                    ),
                                  ),
                                  CustomText(
                                    text: '2 Weeks Ago',
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
                                                color: Colors.green
                                                    .withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: const Text(
                                              'Accepted',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
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

                    SizedBox(height: context.responsiveHeight(2)),
// Notification item: Extras Request Rejected (3 Weeks Ago)
                    if (_controller.notificationJobs.length > 5)
                      Dismissible(
                        key: Key(
                            'extras_rejected_5_${_controller.notificationJobs[5].title}'),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          _controller.removeNotification(5);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white),
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
                                      text: 'Extras Request Rejected',
                                      fontWeight: FontWeight.w500,
                                      fontSize: context.responsiveFontSize(16),
                                    ),
                                  ),
                                  CustomText(
                                    text: '3 Weeks Ago',
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
                                        extrasStatus: 'rejected',
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
                                                  Colors.red.withOpacity(0.1),
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
                                                'Extras Rejected',
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
                                                  Colors.red.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color:
                                                    Colors.red.withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: const Text(
                                              'Rejected',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
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
                  ],
                ],
              )),
        ),
      ),
    );
  }
}
