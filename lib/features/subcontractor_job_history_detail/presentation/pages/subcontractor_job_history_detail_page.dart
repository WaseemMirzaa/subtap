part of 'pages.dart';

class SubcontractorJobHistoryDetailPage extends StatefulWidget {
  final JobHistory job;
  final bool isOpenJob;

  const SubcontractorJobHistoryDetailPage({
    super.key,
    required this.job,
    required this.isOpenJob,
  });

  @override
  State<SubcontractorJobHistoryDetailPage> createState() =>
      _SubcontractorJobHistoryDetailPageState();
}

class _SubcontractorJobHistoryDetailPageState
    extends State<SubcontractorJobHistoryDetailPage> {
  // Add this state variable
  bool isDescriptionExpanded = false;

  // Static list of extras
  List<Map<String, dynamic>> staticExtras = [
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

  // Reactive status for extras
  final RxString extrasStatus = 'pending'.obs;

  // Initialize ExtrasController
  final ExtrasController extrasController = Get.put(ExtrasController());

  // Method to calculate total for card summary
  double _calculateTotal() {
    return staticExtras.fold(
        0.0, (sum, item) => sum + (item['price'] as double? ?? 0.0));
  }

  // Method to show extras bottom sheet
  void _showExtrasBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ExtrasBottomSheet(
          extrasData: staticExtras,
          extrasStatus: extrasStatus.value,
          onClose: () => Navigator.pop(context),
        );
      },
    );
  }

  // Method to show status selection dialog
  void _showStatusSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Approved'),
                onTap: () {
                  extrasStatus.value = 'approved';
                  Navigator.pop(context);
                  Get.snackbar(
                    'Success',
                    'Extras marked as Approved',
                    backgroundColor: Colors.green,
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: AppColor.white,
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 3),
                  );
                },
              ),
              ListTile(
                title: const Text('Rejected'),
                onTap: () {
                  extrasStatus.value = 'rejected';
                  Navigator.pop(context);
                  Get.snackbar(
                    'Info',
                    'Extras marked as Rejected',
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: AppColor.white,
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 3),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFullScreenImage(String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const kGap10 = SizedBox(height: 10);
    const kGap20 = SizedBox(height: 20);

    return SubtapScaffold(
      appBar: SubcontractorJobHistoryDetailAppbar(
        jobTitle: widget.job.title ?? 'Job Details',
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      // Job title, price, and status row
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
                            child: Center(
                              child: SvgPicture.asset(
                                widget.job.svgIcon ?? '',
                                width: 28,
                                height: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.job.title ?? 'No Title',
                                  style: const TextStyle(
                                    color: AppColor.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.svgsGeneral,
                                      width: 16,
                                      height: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Carpentry & Framing ',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    'HelveticaNeueMedium',
                                                color: AppColor.midGray,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 100),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  widget.job.status == 'Active Jobs'
                                      ? Assets.svgsActive
                                      : Assets.svgsTime,
                                  width: 14,
                                  height: 14,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // Divider
                      const Divider(
                        color: AppColor.mediumGray,
                        thickness: 1,
                        height: 1,
                      ),
                      // Budget, Due Date, Address Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.lightGray,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            // Target Budget
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svgsTargetBudget,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Target Budget: ',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'HelveticaNeueMedium',
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.job.targetBudget,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColor.midGray,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'HelveticaNeueMedium',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Due Date
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svgsDueDate,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Due Date: ',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'HelveticaNeueMedium',
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.job.dueDate,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColor.midGray,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'HelveticaNeueMedium',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Address
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svgsLocation,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Address: ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'HelveticaNeueMedium',
                                          ),
                                        ),
                                        TextSpan(
                                          text: widget.job.address,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColor.midGray,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'HelveticaNeueMedium',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      kGap20,
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.lightGray,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.job.description ??
                                  'No description available',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColor.midGray,
                                fontFamily: 'HelveticaNeueMedium',
                              ),
                              maxLines: isDescriptionExpanded ? null : 2,
                              overflow: isDescriptionExpanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                            ),
                            if ((widget.job.description?.length ?? 0) >
                                100) ...[
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDescriptionExpanded =
                                        !isDescriptionExpanded;
                                  });
                                },
                                child: Text(
                                  isDescriptionExpanded
                                      ? 'View less'
                                      : 'View more',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '3 Photos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                _showFullScreenImage(Assets.imagesWood),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                Assets.imagesWood,
                                width: 70,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          kGap10,
                          GestureDetector(
                            onTap: () =>
                                _showFullScreenImage(Assets.imagesWoodie),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                Assets.imagesWoodie,
                                width: 70,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          kGap10,
                          GestureDetector(
                            onTap: () =>
                                _showFullScreenImage(Assets.imagesSideWood),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                Assets.imagesSideWood,
                                width: 70,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kGap20,
                      // Extras Card
                      if (widget.job.status == 'Active Jobs')
                        Obx(() => Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: extrasController.isSubmitting.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.orange),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Extras (${staticExtras.length} items): \$${_calculateTotal().toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.black,
                                                  fontFamily:
                                                      'HelveticaNeueMedium',
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              GestureDetector(
                                                onTap: () =>
                                                    _showStatusSelectionDialog(
                                                        context),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: extrasStatus.value ==
                                                            'approved'
                                                        ? Colors.green
                                                            .withOpacity(0.1)
                                                        : extrasStatus.value ==
                                                                'rejected'
                                                            ? Colors.red
                                                                .withOpacity(
                                                                    0.1)
                                                            : Colors.orange
                                                                .withOpacity(
                                                                    0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      color: extrasStatus
                                                                  .value ==
                                                              'approved'
                                                          ? Colors.green
                                                          : extrasStatus
                                                                      .value ==
                                                                  'rejected'
                                                              ? Colors.red
                                                              : Colors.orange,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    extrasStatus.value ==
                                                            'approved'
                                                        ? 'Approved'
                                                        : extrasStatus.value ==
                                                                'rejected'
                                                            ? 'Denied'
                                                            : 'Waiting',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: extrasStatus
                                                                  .value ==
                                                              'approved'
                                                          ? Colors.green
                                                          : extrasStatus
                                                                      .value ==
                                                                  'rejected'
                                                              ? Colors.red
                                                              : Colors.orange,
                                                      fontFamily:
                                                          'HelveticaNeueMedium',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: _showExtrasBottomSheet,
                                          child: const Text(
                                            'View All',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'HelveticaNeueMedium',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            )),
                      kGap20,
                      if (widget.job.status == 'Active Jobs') ...[
                        const Text(
                          'Status:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const StatusTimeline(
                          statuses: [
                            {
                              'status': 'Assigned',
                              'isCompleted': true,
                              'date': '2:00pm - May 21, 2025'
                            },
                            {
                              'status': 'In Progress',
                              'isCompleted': true,
                              'date': '2:00pm - May 22, 2025'
                            },
                            {
                              'status': 'Completed',
                              'isCompleted': true,
                              'date': '2:00pm - May 22, 2025'
                            },
                          ],
                        ),
                        kGap20,
                      ],
                    ],
                  ),
                ),
              ),
              // Add empty container to prevent bottom overflow when action bar is visible
              if (widget.isOpenJob || widget.job.status == 'Active Jobs')
                const SizedBox(
                    height: 170), // Increased height for additional button
            ],
          ),
          // Bottom action bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomActionBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    if (widget.isOpenJob) {
      // Invited Jobs - Show Accept/Decline
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            CustomButton(
              text: 'Accept Job',
              onTap: () {
                Get.toNamed(AppRoutes.subcontractorJob, arguments: {
                  'job': widget.job,
                  'isFromAcceptJob': true,
                });
              },
              color: AppColor.mutedGold,
              textColor: Colors.white,
              fontWeight: FontWeight.w400,
              radius: 14,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Decline Job',
              onTap: () {
                Get.back();
              },
              color: AppColor.white,
              textColor: AppColor.black,
              fontWeight: FontWeight.w400,
              radius: 14,
            ),
          ],
        ),
      );
    } else if (widget.job.status == 'Active Jobs') {
      // Active Jobs - Show buttons based on timeline status
      String currentStatus = _getCurrentJobStatus();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: _buildStatusBasedButtons(currentStatus),
        ),
      );
    } else if (widget.job.status == 'Completed' ||
        widget.job.status == 'Declined' ||
        widget.job.status == 'Cancelled') {
      // Job History - Show Request Review (only for Completed)
      return widget.job.status == 'Completed'
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColor.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  CustomButton(
                    text: '	✅  Request Review',
                    onTap: () {
                      Get.snackbar(
                        'Review',
                        'Review request submitted',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                    color: AppColor.mutedGold,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w400,
                    radius: 14,
                  ),
                ],
              ),
            )
          : const SizedBox.shrink();
    } else {
      return const SizedBox.shrink();
    }
  }

  String _getCurrentJobStatus() {
    // Check timeline statuses to determine current status
    // This is a simplified logic - adjust based on your actual status tracking
    return 'Assigned'; // Default for demo - replace with actual logic
  }

  List<Widget> _buildStatusBasedButtons(String currentStatus) {
    List<Widget> buttons = [];

    switch (currentStatus) {
      case 'Assigned':
        buttons.addAll([
          CustomButton(
            text: '📷 Upload Progress',
            onTap: () {
              Get.toNamed(AppRoutes.uploadProgress);
            },
            color: AppColor.mutedGold,
            textColor: Colors.white,
            fontWeight: FontWeight.w400,
            radius: 14,
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: '⚖️ Add Mediation',
            onTap: () {
              Get.toNamed(AppRoutes.mediationProcess, arguments: {
                'jobTitle': widget.job.title,
                // 'jobId': widget.job.id ?? widget.job.title,
              });
            },
            color: AppColor.white,
            textColor: AppColor.black,
            fontWeight: FontWeight.w400,
            radius: 14,
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: '➕ Add Extras',
            onTap: () {
              // Initialize controller with job data BEFORE opening bottom sheet
              final extrasController = Get.put(ExtrasController());

              // Initialize with job data immediately
              extrasController.initializeJobData(
                jobTitle: widget.job.title ?? 'Unknown Job',
                jobId: '#${widget.job.title?.hashCode ?? 0}',
                budget: widget.job.price ?? 0.0,
              );

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return const CustomExtraBottomSheet();
                },
              ).then((result) {
                if (result != null &&
                    result is Map<String, dynamic> &&
                    result['success'] == true) {
                  setState(() {
                    if (result['extrasData'] != null) {
                      staticExtras.addAll(List<Map<String, dynamic>>.from(
                          result['extrasData']));
                    }
                  });
                }
                // Clean up controller after bottom sheet closes
                Get.delete<ExtrasController>();
              });
            },
            color: AppColor.white,
            textColor: AppColor.black,
            fontWeight: FontWeight.w400,
            radius: 14,
          ),
        ]);
        break;

      // case 'In Progress':
      //   buttons.addAll([
      //     CustomButton(
      //       text: '📷 Upload Progress',
      //       onTap: () {
      //         Get.toNamed(AppRoutes.uploadProgress);
      //       },
      //       color: AppColor.mutedGold,
      //       textColor: Colors.white,
      //       fontWeight: FontWeight.w400,
      //       radius: 14,
      //     ),
      //     const SizedBox(height: 12),
      //     CustomButton(
      //       text: '➕ Add Extras',
      //       onTap: () {
      //         extrasController.isSubmitting.value = false;
      //         showModalBottomSheet(
      //           context: context,
      //           isScrollControlled: true,
      //           backgroundColor: AppColor.backgroundColor,
      //           shape: const RoundedRectangleBorder(
      //             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      //           ),
      //           builder: (BuildContext context) {
      //             return const CustomExtraBottomSheet();
      //           },
      //         ).then((result) {
      //           if (result != null &&
      //               result is Map<String, dynamic> &&
      //               result['success'] == true) {
      //             setState(() {
      //               if (result['extrasData'] != null) {
      //                 staticExtras.addAll(List<Map<String, dynamic>>.from(
      //                     result['extrasData']));
      //               }
      //             });
      //           }
      //           extrasController.isSubmitting.value = false;
      //         });
      //       },
      //       color: AppColor.white,
      //       textColor: AppColor.black,
      //       fontWeight: FontWeight.w400,
      //       radius: 14,
      //     ),
      //     const SizedBox(height: 12),
      //     CustomButton(
      //       text: '⚖️ Add Mediation',
      //       onTap: () {
      //         Get.toNamed(AppRoutes.mediationProcess);
      //       },
      //       color: AppColor.white,
      //       textColor: AppColor.black,
      //       fontWeight: FontWeight.w400,
      //       radius: 14,
      //     ),
      //   ]);
      // break;

      case 'Completed':
        buttons.addAll([
          CustomButton(
            text: '⭐ Request Review',
            onTap: () {
              // Navigate to review request page
              Get.snackbar(
                'Review',
                'Review request submitted',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            color: AppColor.mutedGold,
            textColor: Colors.white,
            fontWeight: FontWeight.w400,
            radius: 14,
          ),
        ]);
        break;

      default:
        // Fallback to original buttons
        buttons.addAll([
          CustomButton(
            text: '📷 Upload Progress',
            onTap: () {
              Get.toNamed(AppRoutes.uploadProgress);
            },
            color: AppColor.mutedGold,
            textColor: Colors.white,
            fontWeight: FontWeight.w400,
            radius: 14,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.mediationProcess, arguments: {
                'jobTitle': widget.job.title,
                // 'jobId': widget.job.id ?? widget.job.title,
              });
            },
            child: const Text(
              '⚖️ Mediation Process',
              style: TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'HelveticaNeueMedium',
              ),
            ),
          ),
        ]);
    }

    return buttons;
  }
}
