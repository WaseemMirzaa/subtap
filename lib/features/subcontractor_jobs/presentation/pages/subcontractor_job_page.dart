part of 'pages.dart';

class SubcontractorJobPage extends StatefulWidget {
  const SubcontractorJobPage({super.key});

  @override
  State<SubcontractorJobPage> createState() => _SubcontractorJobPageState();
}

class _SubcontractorJobPageState extends State<SubcontractorJobPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  bool _makeCounterOffer = false;

  List<Map<String, TextEditingController>> _lineItems = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Clear all controllers first
    _descriptionController.clear();
    _titleController.clear();
    _startDateController.clear();
    _endDateController.clear();

    // Dispose existing line items
    for (var item in _lineItems) {
      item['description']?.dispose();
      item['price']?.dispose();
    }

    if (_makeCounterOffer) {
      // Toggle ON state - pre-filled data
      _descriptionController.text =
          "I hope you're well. I'm looking to get some carpentry & farming.";
      _lineItems = [
        {
          'description': TextEditingController(text: 'Labor'),
          'price': TextEditingController(text: '\$600'),
        },
        {
          'description': TextEditingController(text: 'Materials'),
          'price': TextEditingController(text: '\$200'),
        }
      ];
      // Set default dates when toggle is ON
      _startDateController.text = '2023-01-01';
      _endDateController.text = '2023-01-31';
    } else {
      // Toggle OFF state - empty fields
      _lineItems = [
        {
          'description': TextEditingController(),
          'price': TextEditingController(),
        }
      ];
    }
  }

  void _addNewLineItem() {
    if (!_makeCounterOffer) {
      setState(() {
        _lineItems.add({
          'description': TextEditingController(),
          'price': TextEditingController(),
        });
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    for (var item in _lineItems) {
      item['description']?.dispose();
      item['price']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SubtapScaffold(
      appBar: const SubcontractorJobAppbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Toggle Switch Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: _makeCounterOffer
                            ? 'Make a Cuunter Offer'
                            : 'Accept Job As-Is',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _makeCounterOffer = !_makeCounterOffer;
                            _initializeControllers();
                          });
                        },
                        child: Container(
                          width: 55,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: _makeCounterOffer
                                ? AppColor.mutedGold
                                : AppColor.darkBlueShade,
                          ),
                          child: AnimatedAlign(
                            alignment: _makeCounterOffer
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              width: 24,
                              height: 24,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(20),

                  // Scope Section
                  CustomText(
                    text: 'Scope',
                    fontSize: screenWidth > 600 ? 18 : 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  const Gap(5),
                  CustomTextField(
                    fontStyle: FontStyle.normal,
                    fillColor: AppColor.white,
                    controller: _descriptionController,
                    borderColor: AppColor.white,
                    hintText: 'Enter',
                    hintTextColor: AppColor.darkGrayShade,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    height: screenHeight * 0.13,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.04,
                    ),
                    readOnly: _makeCounterOffer,
                  ),
                  const Gap(20),

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
                      hintText: '1000',
                      fontStyle: FontStyle.normal,
                      hintTextColor: AppColor.darkGrayShade,
                      keyboardType: TextInputType.text,
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
                          CustomText(
                            text: 'Line item Description',
                            fontSize: screenWidth > 600 ? 18 : 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: CustomText(
                              text: 'Price (\$)',
                              fontSize: screenWidth > 600 ? 18 : 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Gap(5),

                      // Dynamic Line Items
                      Column(
                        children: _lineItems.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Description field
                                SizedBox(
                                  width: screenWidth * 0.5,
                                  child: CustomTextField(
                                    fillColor: AppColor.white,
                                    controller: item['description'],
                                    borderColor: AppColor.white,
                                    contentPadding: const EdgeInsets.symmetric(
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
                                  width: screenWidth * 0.3,
                                  child: CustomTextField(
                                    fillColor: AppColor.white,
                                    controller: item['price'],
                                    borderColor: AppColor.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 14,
                                    ),
                                    borderRadius: 10,
                                    height: 45,
                                    hintText: 'Price field',
                                    fontStyle: FontStyle.normal,
                                    hintTextColor: AppColor.darkGrayShade,
                                    keyboardType: TextInputType.number,
                                    readOnly: _makeCounterOffer,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      GestureDetector(
                        onTap: _addNewLineItem,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Assets.svgsAddIcon,
                              width: 2,
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
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.45,
                        child: DateTimePicker(
                          hintText: 'End Date',
                          controller: _endDateController,
                          readOnly: _makeCounterOffer,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: _makeCounterOffer
                          ? 'Accept Job As-Is'
                          : 'Submit Progress for Mark as Complete',
                      onTap: () {
                        Get.toNamed(
                          AppRoutes
                              .subcontractorJobHistory, // Make sure you have this route defined
                          arguments: {
                            'initialTab': 'Active Jobs'
                          }, // Pass the tab you want to show
                        );
                      },
                      color: AppColor.mutedGold,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w400,
                      radius: 17,
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
