part of 'pages.dart';

class JobRequestPage extends StatefulWidget {
  const JobRequestPage({super.key});

  @override
  State<JobRequestPage> createState() => _JobRequestPageState();
}

class _JobRequestPageState extends State<JobRequestPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _targetBudgetController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Detect if the keyboard is open
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SubtapScaffold(
      appBar: const JobRequestAppBar(),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
                top: screenHeight * 0.02,
                bottom: 80, // Space for the fixed bottom container
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
                      // Title Field
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
                      const Gap(10),
                      CustomText(
                        text: 'Description',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      const Gap(10),
                      CustomTextField(
                        fontStyle: FontStyle.normal,
                        fillColor: AppColor.white,
                        controller: _descriptionController,
                        borderColor: AppColor.white,
                        hintText: 'Describe what needs fixing...',
                        hintTextColor: AppColor.darkGrayShade,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        height: screenHeight * 0.13,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.04,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const Gap(10),
                      // Location
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
                        controller: _locationController,
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
                        controller: _targetBudgetController,
                        borderColor: AppColor.white,
                        fontStyle: FontStyle.normal,
                        hintText: 'Enter Budget',
                        hintTextColor: AppColor.darkGrayShade,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                      kGap10,
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
                        controller: _dueDateController,
                        borderColor: AppColor.white,
                        fontStyle: FontStyle.normal,
                        hintText: 'Enter Due Date',
                        hintTextColor: AppColor.darkGrayShade,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                      kGap10,
                      CustomText(
                        text: 'Images of Job',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      const Gap(10),
                      // Optimized image upload section
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // Calculate item width based on available space
                          final itemWidth = (constraints.maxWidth - 40) /
                              3; // 40 accounts for gaps and padding
                          return Row(
                            children: List.generate(
                              3,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: itemWidth,
                                  height:
                                      itemWidth * 0.75, // Maintain aspect ratio
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
                                        width: itemWidth *
                                            0.25, // Make icon size proportional
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
                      CustomText(
                        text: 'Invite Subcontractor (Sub)',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      kGap10,
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
                      const Gap(80), // Extra space at the bottom
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (!isKeyboardOpen)
            // Fixed bottom container
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
                        onTap: () {},
                        color: AppColor.mutedGold,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w400,
                        radius: 17,
                      ),
                    ),
                    kGap10,
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
