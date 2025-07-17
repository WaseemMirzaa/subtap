part of 'pages.dart';

extension StringExtension on String {
  String get capitalizeFirst {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

class JobHistoryDetailPage extends StatefulWidget {
  final JobHistory job;
  final bool isRequestedJob;

  const JobHistoryDetailPage({
    super.key,
    required this.job,
    required this.isRequestedJob,
  });

  @override
  State<JobHistoryDetailPage> createState() => _JobHistoryDetailPageState();
}

class _JobHistoryDetailPageState extends State<JobHistoryDetailPage> {
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

  @override
  Widget build(BuildContext context) {
    const kGap10 = SizedBox(height: 10);
    const kGap20 = SizedBox(height: 20);

    return SubtapScaffold(
      appBar: const JobHistoryDetailAppBar(),
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
                                  widget.job.title ?? '',
                                  style: const TextStyle(
                                    color: AppColor.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'HelveticaNeueMedium',
                                  ),
                                ),
                                const SizedBox(height: 8),
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
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
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
                      const SizedBox(height: 16),
                      // Target Budget
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svgsTargetBudget,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 4),
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
                      kGap10,
                      // Due Date
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svgsDueDate,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 4),
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
                      kGap10,
                      // Address
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svgsLocation,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 4),
                          RichText(
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
                        ],
                      ),
                      kGap20,
                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.job.description ?? 'No description available',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColor.midGray,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Images
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
                          kGap10,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Assets.imagesSideWood,
                              width: 70,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      kGap20,
                      // Extras Card
                      if (widget.job.status == 'Active Jobs')
                        Obx(() => GestureDetector(
                              onTap: _showExtrasBottomSheet,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.lightGray, width: 1),
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
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: SvgPicture.asset(
                                                  extrasStatus.value ==
                                                          'approved'
                                                      ? Assets.svgsCheck
                                                      : extrasStatus.value ==
                                                              'rejected'
                                                          ? Assets.svgsCancelled
                                                          : Assets.svgsTime,
                                                  width: 16,
                                                  height: 16,
                                                  color: extrasStatus.value ==
                                                          'approved'
                                                      ? Colors.green
                                                      : extrasStatus.value ==
                                                              'rejected'
                                                          ? Colors.red
                                                          : Colors.orange,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Extras Requested',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                          Flexible(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _showStatusSelectionDialog(
                                                          context);
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: extrasStatus
                                                                    .value ==
                                                                'approved'
                                                            ? Colors.green
                                                                .withOpacity(
                                                                    0.1)
                                                            : extrasStatus
                                                                        .value ==
                                                                    'rejected'
                                                                ? Colors.red
                                                                    .withOpacity(
                                                                        0.1)
                                                                : Colors.orange
                                                                    .withOpacity(
                                                                        0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                          color: extrasStatus
                                                                      .value ==
                                                                  'approved'
                                                              ? Colors.green
                                                                  .withOpacity(
                                                                      0.3)
                                                              : extrasStatus
                                                                          .value ==
                                                                      'rejected'
                                                                  ? Colors.red
                                                                      .withOpacity(
                                                                          0.3)
                                                                  : Colors
                                                                      .orange
                                                                      .withOpacity(
                                                                          0.3),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        extrasStatus.value,
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
                                                                  : Colors
                                                                      .orange,
                                                          fontFamily:
                                                              'HelveticaNeueMedium',
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                if (extrasStatus.value ==
                                                    'rejected')
                                                  Flexible(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        extrasStatus.value =
                                                            'pending';
                                                        Get.snackbar(
                                                          'Success',
                                                          'Extras resubmitted for approval',
                                                          backgroundColor:
                                                              Colors.green,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          colorText:
                                                              AppColor.white,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          duration:
                                                              const Duration(
                                                                  seconds: 3),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          border: Border.all(
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    0.3),
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Resubmit',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.blue,
                                                            fontFamily:
                                                                'HelveticaNeueMedium',
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                const SizedBox(width: 4),
                                                const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 12,
                                                  color: AppColor.midGray,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            )),
                      const SizedBox(height: 20),
                      // Subcontractor section
                      Text(
                        widget.isRequestedJob
                            ? 'Proposal Received'
                            : 'Hired Person',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Subcontractor Card
                      SubcontractorJobCard(
                        subcontractor: widget.job.subcontractorModel ??
                            const SubcontractorModel(
                              name: 'Unknown',
                              imageUrl: '',
                              expertise: '',
                              description:
                                  'No subcontractor information available',
                              price: '0.0',
                              rating: 0.0,
                            ),
                        showActionButtons: widget.isRequestedJob,
                        onTap: widget.isRequestedJob
                            ? () {
                                Get.toNamed(
                                  AppRoutes.favSubcontractorProfile,
                                  arguments: {
                                    'subcontractor': {
                                      'name':
                                          widget.job.subcontractorModel?.name ??
                                              'Unknown',
                                      'imageUrl': widget.job.subcontractorModel
                                              ?.imageUrl ??
                                          '',
                                      'expertise': widget.job.subcontractorModel
                                              ?.expertise ??
                                          '',
                                      'description': widget
                                              .job
                                              .subcontractorModel
                                              ?.description ??
                                          '',
                                      'price': widget
                                              .job.subcontractorModel?.price ??
                                          0.0,
                                      'rating': widget
                                              .job.subcontractorModel?.rating ??
                                          0.0,
                                    },
                                    'fromJobHistory': true,
                                    'fromSubcontractorsPage': true,
                                  },
                                );
                              }
                            : null,
                        onAccept: widget.isRequestedJob
                            ? () {
                                NavigationController.to.navigateToMainPage();
                                NavigationController.to.changePage(1);
                                Get.snackbar(
                                  'Success',
                                  'Offer accepted',
                                  backgroundColor: Colors.green,
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: AppColor.white,
                                  margin: const EdgeInsets.all(16),
                                  duration: const Duration(seconds: 3),
                                );
                              }
                            : null,
                        onReject: widget.isRequestedJob
                            ? () {
                                Get.snackbar(
                                  'Info',
                                  'Offer rejected',
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: AppColor.white,
                                  margin: const EdgeInsets.all(16),
                                  duration: const Duration(seconds: 3),
                                );
                              }
                            : null,
                      ),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
              // Add empty container to prevent bottom overflow when action bar is visible
              if (widget.job.status == 'Active Jobs')
                const SizedBox(height: 95),
            ],
          ),
          // Bottom action bar for active jobs
          if (widget.job.status == 'Active Jobs')
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Mark Job Completed Button
                    CustomButton(
                      text: 'Mark Job Completed',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FeedbackScreen(),
                          ),
                        );
                      },
                      color: AppColor.mutedGold,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w400,
                      radius: 14,
                    ),
                    const SizedBox(height: 12),
                    // Add Extra Button
                    CustomButton(
                      text: 'Add Extras',
                      onTap: () {
                        // Initialize controller before opening bottom sheet
                        final extrasController = Get.put(ExtrasController());
                        extrasController.initializeJobData(
                          jobTitle: widget.job.title ?? '',
                          jobId: '#${widget.job.title?.hashCode ?? 0}',
                          budget: widget.job.price ?? 0.0,
                        );

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: AppColor.backgroundColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (BuildContext context) {
                            return const CustomExtraBottomSheet();
                          },
                        ).then((result) {
                          if (result != null &&
                              result is Map<String, dynamic> &&
                              result['success'] == true) {
                            setState(() {
                              if (result['extrasData'] != null) {
                                staticExtras.addAll(
                                    List<Map<String, dynamic>>.from(
                                        result['extrasData']));
                              }
                            });
                          }
                          // Clean up controller after bottom sheet closes
                          Get.delete<ExtrasController>();
                        });
                      },
                      color: AppColor.mutedGold,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w500,
                      radius: 14,
                    ),
                    // Mediation Process Button
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.mediationProcess);
                      },
                      child: const Text(
                        'Mediation Process',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
