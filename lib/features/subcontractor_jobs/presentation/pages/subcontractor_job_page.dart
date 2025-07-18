part of 'pages.dart';

class SubcontractorJobPage extends StatefulWidget {
  final bool isFromAcceptJob;
  const SubcontractorJobPage({
    super.key,
    this.isFromAcceptJob = false,
  });

  @override
  State<SubcontractorJobPage> createState() => _SubcontractorJobPageState();
}

class _SubcontractorJobPageState extends State<SubcontractorJobPage> {
  late SubcontractorJobController controller;

  // Add these missing variables
  bool get _makeCounterOffer => controller.makeCounterOffer.value;
  List<Map<String, TextEditingController>> get _lineItems =>
      controller.lineItems;
  TextEditingController get _titleController => controller.titleController;
  TextEditingController get _startDateController =>
      controller.startDateController;
  TextEditingController get _endDateController => controller.endDateController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SubcontractorJobController());
  }

  void _addNewLineItem() {
    controller.addNewLineItem();
  }

  void _removeLineItem(int index) {
    controller.removeLineItem(index);
  }

  void _validateDates() {
    controller.validateDates();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarTitle =
        widget.isFromAcceptJob ? 'Submit Proposal' : 'Accept Job';

    return SubtapScaffold(
      appBar: SubcontractorJobAppbar(title: appBarTitle),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 23, horizontal: 23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Original job info when counter offer is ON
                      Obx(() => controller.makeCounterOffer.value
                          ? Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Original Job Info',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  SizedBox(height: 4),
                                  CustomText(
                                    text: 'Original Budget: \$50, Due: May 23',
                                    fontSize: 12,
                                    color: AppColor.midGray,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink()),

                      // Informational banner when toggle is ON
                      Obx(() => controller.makeCounterOffer.value
                          ? Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.green, size: 20),
                                  const SizedBox(width: 8),
                                  const Expanded(
                                    child: CustomText(
                                      text:
                                          '✅ You are accepting the original job terms. Fields are locked.',
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink()),

                      // Toggle Switch Row - Updated label
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CustomText(
                                text: '✅ Use Original Job Terms',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'This will pre-fill all fields based on the property manager\'s original job post. No edits will be allowed.',
                                      ),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: AppColor.midGray,
                                ),
                              ),
                            ],
                          ),
                          Obx(() => GestureDetector(
                                onTap: controller.toggleCounterOffer,
                                child: Container(
                                  width: 55,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: controller.makeCounterOffer.value
                                        ? AppColor.mutedGold
                                        : AppColor.darkBlueShade,
                                  ),
                                  child: AnimatedAlign(
                                    alignment: controller.makeCounterOffer.value
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    duration: const Duration(milliseconds: 200),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const Gap(20),

                      // Scope Section
                      const ScopeSectionWidget(),
                      const Gap(20),

                      // Attachments Section
                      const AttachmentsSectionWidget(),
                      const Gap(20),

                      // Budget Validation
                      const BudgetValidationWidget(),
                      const Gap(20),

                      // Validation Error Message
                      Obx(() => controller.hasValidationErrors.value
                          ? Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error,
                                      color: Colors.red, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: CustomText(
                                      text: controller.validationMessage.value,
                                      fontSize: 12,
                                      color: Colors.red.shade700,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink()),

                      // Total Budget (only when toggle is OFF)
                      if (!_makeCounterOffer) ...[
                        CustomText(
                          text: 'Total Budget',
                          fontSize: screenWidth > 600 ? 18 : 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                        ),
                        const Gap(5),
                        CustomTextField(
                          fillColor: AppColor.white,
                          controller: _titleController,
                          borderColor: AppColor.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 9,
                            horizontal: 14,
                          ),
                          borderRadius: 10,
                          height: 45,
                          hintText: '\$1000',
                          fontStyle: FontStyle.normal,
                          hintTextColor: AppColor.darkGrayShade,
                          keyboardType: TextInputType.number,
                        ),
                        const Gap(20),
                      ],

                      // Line Items Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.47,
                                child: CustomText(
                                  text: 'Line Item Description',
                                  fontSize: screenWidth > 600 ? 18 : 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: _lineItems.length > 1
                                    ? screenWidth * 0.39
                                    : screenWidth * 0.29,
                                child: CustomText(
                                  text: 'Price (\$)',
                                  fontSize: screenWidth > 600 ? 18 : 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const Gap(5),

                          // Dynamic Line Items
                          Column(
                            children: _lineItems.asMap().entries.map((entry) {
                              int index = entry.key;
                              var item = entry.value;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Description field
                                    SizedBox(
                                      width: screenWidth * 0.46,
                                      child: CustomTextField(
                                        fillColor: AppColor.white,
                                        controller: item['description'],
                                        borderColor: AppColor.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 9,
                                          horizontal: 14,
                                        ),
                                        borderRadius: 10,
                                        height: 45,
                                        hintText: 'Description field',
                                        fontStyle: FontStyle.normal,
                                        hintTextColor: AppColor.darkGrayShade,
                                        keyboardType: TextInputType.text,
                                        readOnly: _makeCounterOffer,
                                      ),
                                    ),

                                    // Price field
                                    SizedBox(
                                      width: screenWidth * 0.29,
                                      child: CustomTextField(
                                        fillColor: AppColor.white,
                                        controller: item['price'],
                                        borderColor: AppColor.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 9,
                                          horizontal: 14,
                                        ),
                                        borderRadius: 10,
                                        height: 46,
                                        hintText: 'Price field',
                                        hintStyle: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'HelveticaNeueLight',
                                            color: AppColor.midGray,
                                            fontWeight: FontWeight.w400),
                                        fontStyle: FontStyle.normal,
                                        hintTextColor: AppColor.darkGrayShade,
                                        keyboardType: TextInputType.number,
                                        readOnly: _makeCounterOffer,
                                      ),
                                    ),

                                    // Delete Icon (visible only when toggle is off and more than one item)
                                    if (!_makeCounterOffer &&
                                        _lineItems.length > 1)
                                      GestureDetector(
                                        onTap: () => _removeLineItem(index),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: SvgPicture.asset(
                                            Assets.svgsDelete,
                                            width: 20,
                                            height: 20,
                                            color: AppColor.black,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),

                          // Add Item button - only show when toggle is OFF
                          if (!_makeCounterOffer)
                            GestureDetector(
                              onTap: _addNewLineItem,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    Assets.svgsAddIcon,
                                    width: 12,
                                    height: 12,
                                    color: AppColor.black,
                                  ),
                                  const SizedBox(width: 8),
                                  const CustomText(
                                    text: 'Add Item',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.black,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const Gap(20),

                      // Timeline Section
                      CustomText(
                        text: 'Timeline',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.40,
                            child: DateTimePicker(
                              hintText: 'Start Date',
                              controller: _startDateController,
                              readOnly: _makeCounterOffer,
                              onChanged: (value) {
                                if (value != null &&
                                    _endDateController.text.isEmpty) {
                                  // If end date is empty, set it to start date
                                  _endDateController.text = value;
                                } else if (value != null) {
                                  _validateDates();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.45,
                            child: DateTimePicker(
                              hintText: 'End Date',
                              controller: _endDateController,
                              readOnly: _makeCounterOffer,
                              onChanged: (value) {
                                if (value != null) {
                                  _validateDates();
                                }
                              },
                              firstDate: _startDateController.text.isNotEmpty
                                  ? DateTime.parse(_startDateController.text)
                                  : DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),

                      // Budget Summary Section
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Total Budget',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: '\$1000',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: 'Itemized:',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: _makeCounterOffer ? '\$800' : '\$600',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: 'Remaining',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: _makeCounterOffer ? '\$200' : '\$1000',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColor.mutedGold,
                          ),
                        ],
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),

              // Bottom Button
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => CustomButton(
                              text: controller.makeCounterOffer.value
                                  ? 'Confirm Acceptance'
                                  : 'Submit Proposal',
                              onTap: controller.showPreviewModal,
                              color: AppColor.mutedGold,
                              textColor: Colors.white,
                              fontWeight: FontWeight.w400,
                              radius: 17,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Preview Modal
          const PreviewModalWidget(),
        ],
      ),
    );
  }
}
