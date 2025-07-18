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
    return SubtapScaffold(
      appBar: const NotificationAppbar(),
      body: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Clear All button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Notifications',
                        fontWeight: FontWeight.w500,
                        fontSize: context.responsiveFontSize(18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text('Clear All Read Notifications'),
                              content: const Text(
                                  'Are you sure you want to clear all read notifications?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _controller.clearAllRead();
                                    Get.back();
                                  },
                                  child: const Text('Clear All'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColor.lightGray.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.delete_outline,
                                  size: 16, color: AppColor.midGray),
                              SizedBox(width: 4),
                              CustomText(
                                text: 'Clear All',
                                fontSize: 12,
                                color: AppColor.midGray,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.responsiveHeight(1.5)),

                  // Filter tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _controller.tabs.map((tab) {
                        final isSelected = _controller.selectedTab.value == tab;
                        return GestureDetector(
                          onTap: () => _controller.changeTab(tab),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.mutedGold
                                  : AppColor.lightGray.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CustomText(
                              text: tab,
                              fontSize: 14,
                              color: isSelected
                                  ? AppColor.white
                                  : AppColor.darkGray,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: context.responsiveHeight(2)),

                  // Notifications content
                  _buildNotificationsList(context),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildNotificationsList(BuildContext context) {
    if (_controller.filteredNotifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.notifications_off_outlined,
              size: 48,
              color: AppColor.midGray,
            ),
            const SizedBox(height: 16),
            const CustomText(
              text: 'No notifications found',
              fontWeight: FontWeight.w400,
              fontSize: 16, // Use fixed size instead of responsive
              color: AppColor.midGray,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: _controller.selectedTab.value == 'All'
                  ? 'You don\'t have any notifications yet'
                  : 'No ${_controller.selectedTab.value.toLowerCase()} notifications',
              fontWeight: FontWeight.w400,
              fontSize: 14, // Use fixed size instead of responsive
              color: AppColor.midGray,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // List of notifications
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _controller.filteredNotifications.length,
          itemBuilder: (context, index) {
            final notification = _controller.filteredNotifications[index];
            final notificationColor =
                _controller.getNotificationColor(notification.title ?? '');

            return _buildNotificationCard(
                context, notification, index, notificationColor);
          },
        ),

        // Add at the end of the notifications list
        if (_controller.filteredNotifications.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Column(
                children: [
                  const CustomText(
                    text: 'No More Notifications',
                    color: AppColor.midGray,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      // Load older notifications
                      Get.snackbar('Loading', 'Loading older notifications...',
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    child: const Text('Load Older'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNotificationCard(BuildContext context, JobHistory notification,
      int index, Color notificationColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: Key('notification_${index}_${notification.title}'),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.archive_outlined, color: Colors.white),
              SizedBox(height: 4),
              CustomText(text: 'Archive', color: Colors.white, fontSize: 12),
            ],
          ),
        ),
        onDismissed: (direction) {
          HapticFeedback.heavyImpact(); // Add haptic feedback
          _controller.archiveNotification(index);

          Get.snackbar(
            'Notification Archived',
            'The notification has been archived',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black54,
            colorText: Colors.white,
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
            mainButton: TextButton(
              onPressed: () {
                notification.isArchived = false;
                _controller.notificationJobs.refresh();
                Get.closeCurrentSnackbar();
              },
              child: const Text('UNDO', style: TextStyle(color: Colors.white)),
            ),
          );
        },
        child: Semantics(
          label: _getSemanticLabel(notification),
          child: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _controller.markAsRead(index);
              Get.toNamed(
                AppRoutes.subcontractorJobHistoryDetail,
                arguments: {
                  'job': notification,
                  'isOpenJob': false,
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: notification.isRead
                    ? null
                    : Border.all(color: notificationColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title and time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!notification.isRead)
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(right: 8, top: 4),
                                decoration: BoxDecoration(
                                  color: notificationColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            Expanded(
                              child: CustomText(
                                text: notification.title ?? '',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomText(
                        text: _getFormattedTime(notification),
                        color: AppColor.midGray,
                        fontSize: 12,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Description with AI-checked content and expandable text
                  ExpandableText(
                    _getAICheckedContent(notification.description ?? ''),
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColor.midGray,
                      height: 1.4,
                    ),
                    expandText: 'View More',
                    collapseText: 'Show Less',
                    linkColor: AppColor.mutedGold,
                  ),

                  // Due date when available
                  if (notification.dueDate != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              size: 14, color: AppColor.midGray),
                          const SizedBox(width: 4),
                          CustomText(
                            text: 'Due: ${notification.dueDate}',
                            fontSize: 12,
                            color: AppColor.midGray,
                          ),
                        ],
                      ),
                    ),

                  // Extras preview with item details
                  if (notification.title?.contains('Extras') == true)
                    _buildExtrasPreview(),

                  // Action buttons
                  if (notification.title?.contains('Job Opportunity') == true ||
                      notification.title?.contains('Extras Requested') == true)
                    GestureDetector(
                      onTap: () {},
                      child: _buildActionButtons(notification),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getSemanticLabel(JobHistory notification) {
    final title = notification.title ?? '';
    final name = notification.subcontractorModel?.name ?? 'Property Manager';

    if (title.contains('Job Opportunity')) {
      return 'Job Invite from $name. Accept or Reject.';
    } else if (title.contains('Extras')) {
      return 'Extras request from $name worth \$225. Accept or Reject.';
    } else {
      return '$title from $name. Tap to view details.';
    }
  }

  String _getFormattedTime(JobHistory notification) {
    final now = DateTime.now();
    final notificationTime = DateTime.now().subtract(const Duration(hours: 2));

    if (now.difference(notificationTime).inHours < 24) {
      return 'Today at ${notificationTime.hour}:${notificationTime.minute.toString().padLeft(2, '0')} ${notificationTime.hour >= 12 ? 'PM' : 'AM'}';
    } else if (now.difference(notificationTime).inDays == 1) {
      return 'Yesterday';
    } else if (now.difference(notificationTime).inDays < 7) {
      return '${now.difference(notificationTime).inDays} days ago';
    } else {
      return '1 week ago';
    }
  }

  String _getAICheckedContent(String content) {
    // Simulate AI spelling/grammar check
    return content
        .replaceAll('recieved', 'received')
        .replaceAll('submited', 'submitted')
        .replaceAll('convienience', 'convenience');
  }

  Widget _buildExtrasPreview() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.lightGray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Extras Preview:',
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            const SizedBox(height: 4),
            const CustomText(
              text: '• Extra Beams (\$150)',
              fontSize: 11,
              color: AppColor.midGray,
            ),
            const CustomText(
              text: '• Extra Wood (\$75)',
              fontSize: 11,
              color: AppColor.midGray,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: 'Total: \$225',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColor.mutedGold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(JobHistory notification) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomButton(
              text: 'Chat with PM',
              color: AppColor.mutedGold,
              textColor: AppColor.black,
              radius: 8,
              fontSize: 12,
              height: 40,
              onTap: () {
                HapticFeedback.mediumImpact();
                // Navigate to chat detail page with property manager info
                Get.toNamed(
                  AppRoutes.chatDetailPage,
                  arguments: {
                    'userName': notification.propertyManager?.name ??
                        'Property Manager',
                    'avatarImage': notification.propertyManager?.imageUrl ??
                        Assets.imagesChatMichael,
                  },
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomButton(
              text: 'REJECT',
              color: const Color(0xFF8B0000),
              textColor: AppColor.white,
              radius: 8,
              fontSize: 12,
              height: 40,
              onTap: () => _handleReject(notification),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomButton(
              text: 'ACCEPT',
              color: const Color(0xFF1B365D),
              textColor: AppColor.white,
              radius: 8,
              fontSize: 12,
              height: 40,
              onTap: () => _handleAccept(notification),
            ),
          ),
        ],
      ),
    );
  }

  void _handleReject(JobHistory notification) {
    HapticFeedback.heavyImpact(); // Strong haptic feedback

    if (notification.title?.contains('Extras') == true) {
      Get.dialog(
        AlertDialog(
          title: const Text('Reject Extras'),
          content: const Text(
              'Are you sure you want to reject these extras worth \$225?'),
          actions: [
            TextButton(
                onPressed: () => Get.back(), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                Get.back();
                Get.snackbar(
                    'Extras Rejected', 'You have rejected the extras request',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: const Text('Reject'),
            ),
          ],
        ),
      );
    } else {
      Get.snackbar('Job Rejected', 'You have rejected the job opportunity',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _handleAccept(JobHistory notification) {
    HapticFeedback.heavyImpact(); // Strong haptic feedback

    if (notification.title?.contains('Extras') == true) {
      Get.dialog(
        AlertDialog(
          title: const Text('Accept Extras'),
          content: const Text('Confirm you want to accept extras worth \$225?'),
          actions: [
            TextButton(
                onPressed: () => Get.back(), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                Get.back();
                Get.snackbar(
                    'Extras Accepted', 'You have accepted the extras request',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    }
  }
}
