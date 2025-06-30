part of 'pages.dart';

class JobRequestPage extends StatelessWidget {
  final String? initialTitle;
  final Map<String, dynamic>? subcontractor;
  const JobRequestPage({super.key, this.initialTitle, this.subcontractor});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final JobRequestController controller = Get.put(JobRequestController());

    // Set initial title if provided
    if (initialTitle != null) {
      controller.titleController.text = initialTitle!;
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SubtapScaffold(
      appBar: const JobRequestAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
                top: screenHeight * 0.02,
                bottom: 80,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth > 600 ? 400 : screenWidth * 0.96,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Title',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                      const Gap(10),
                      CustomTextField(
                        fillColor: AppColor.white,
                        controller: controller.titleController,
                        borderColor: AppColor.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 9,
                          horizontal: 14,
                        ),
                        borderRadius: 10,
                        height: 45,
                        hintText: 'Write title',
                        fontStyle: FontStyle.normal,
                        hintTextColor: AppColor.darkGrayShade,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const Gap(15),
                      // Line Items Section (from SubcontractorJobPage)
                      Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    width: controller.lineItems.length > 1
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
                              const Gap(10),
                              // Dynamic Line Items
                              Column(
                                children:
                                    controller.lineItems.asMap().entries.map(
                                  (entry) {
                                    int index = entry.key;
                                    var item = entry.value;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
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
                                              hintTextColor:
                                                  AppColor.darkGrayShade,
                                              keyboardType: TextInputType.text,
                                              readOnly: controller
                                                  .makeCounterOffer.value,
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
                                                fontFamily:
                                                    'HelveticaNeueLight',
                                                color: AppColor.midGray,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              fontStyle: FontStyle.normal,
                                              hintTextColor:
                                                  AppColor.darkGrayShade,
                                              keyboardType:
                                                  TextInputType.number,
                                              readOnly: controller
                                                  .makeCounterOffer.value,
                                            ),
                                          ),
                                          // Delete Icon
                                          if (!controller
                                                  .makeCounterOffer.value &&
                                              controller.lineItems.length > 1)
                                            GestureDetector(
                                              onTap: () => controller
                                                  .removeLineItem(index),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
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
                                  },
                                ).toList(),
                              ),
                              GestureDetector(
                                onTap: controller.addNewLineItem,
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
                          )),
                      const Gap(10),
                      CustomText(
                        text: 'Location',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      const Gap(10),
                      CustomTextField(
                        height: 45,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 9,
                          horizontal: 14,
                        ),
                        fillColor: AppColor.white,
                        controller: controller.locationController,
                        borderColor: AppColor.white,
                        fontStyle: FontStyle.normal,
                        hintText: 'Auto-fill from GPS or manual entry',
                        hintTextColor: AppColor.darkGrayShade,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                      const Gap(10),
                      CustomText(
                        text: 'Target Budget',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      const Gap(10),
                      CustomTextField(
                        height: 45,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 9,
                          horizontal: 14,
                        ),
                        fillColor: AppColor.white,
                        controller: controller.targetBudgetController,
                        borderColor: AppColor.white,
                        fontStyle: FontStyle.normal,
                        hintText: 'Enter Budget',
                        hintTextColor: AppColor.darkGrayShade,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a budget';
                          }
                          return null;
                        },
                      ),
                      const Gap(10),
                      CustomText(
                        text: 'Due Date',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      const Gap(10),
                      CustomTextField(
                        height: 45,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 9,
                          horizontal: 14,
                        ),
                        fillColor: AppColor.white,
                        controller: controller.dueDateController,
                        borderColor: AppColor.white,
                        fontStyle: FontStyle.normal,
                        hintText: 'Enter Due Date',
                        hintTextColor: AppColor.darkGrayShade,
                        readOnly: true,
                        keyboardType: TextInputType.none,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            controller.dueDateController.text = formattedDate;
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a due date';
                          }
                          DateTime selectedDate =
                              DateFormat('yyyy-MM-dd').parse(value);
                          if (selectedDate.isBefore(DateTime.now()
                              .subtract(const Duration(days: 1)))) {
                            return 'Due date cannot be in the past';
                          }
                          return null;
                        },
                      ),
                      const Gap(10),
                      CustomText(
                        text: 'Images of Job',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      const Gap(10),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final itemWidth = (constraints.maxWidth - 40) / 3;
                          return Row(
                            children: List.generate(
                              3,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: itemWidth,
                                  height: itemWidth * 0.75,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColor.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.svgsImageUpload,
                                        width: itemWidth * 0.25,
                                        height: itemWidth * 0.2,
                                      ),
                                      const Gap(5),
                                      const CustomText(
                                        text: 'Upload Image',
                                        fontSize: 11,
                                        color: AppColor.darkGrayShade,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Gap(20),
                      if (subcontractor == null) ...[
                        CustomText(
                          text: 'Invite Subcontractor (Sub)',
                          fontSize: screenWidth > 600 ? 18 : 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        const Gap(10),
                        CustomButton(
                          text: 'Tap to Invite',
                          height: 40,
                          onTap: () {
                            Get.toNamed(AppRoutes.inviteSubcontractorPage);
                          },
                          width: double.infinity,
                          color: AppColor.white,
                          textColor: AppColor.darkGrayShade,
                          fontWeight: FontWeight.normal,
                          radius: 13,
                          fontSize: screenWidth > 600 ? 18 : 16,
                        ),
                      ],
                      const Gap(80),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (!isKeyboardOpen)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 95,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Submit a Request',
                        onTap: () {
                          NavigationController.to.navigateToMainPage();
                          NavigationController.to.changePage(1);
                          Get.snackbar(
                            'Success',
                            'Submit Request Successfully',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: AppColor.white,
                            margin: const EdgeInsets.all(16),
                            duration: const Duration(seconds: 3),
                          );
                        },
                        color: AppColor.mutedGold,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w400,
                        radius: 17,
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
