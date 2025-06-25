part of 'pages.dart';

class MediationProcessPage extends StatefulWidget {
  const MediationProcessPage({super.key});

  @override
  State<MediationProcessPage> createState() => _MediationProcessPageState();
}

class _MediationProcessPageState extends State<MediationProcessPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SubtapScaffold(
      appBar: const MediationProcessAppbar(),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Field
                  CustomTextField(
                    fillColor: AppColor.white,
                    controller: _titleController,
                    borderColor: AppColor.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 14,
                    ),
                    borderRadius: 10,
                    hintText: 'Disputes',
                    fontStyle: FontStyle.normal,
                    hintTextColor: AppColor.darkGrayShade,
                    showRightDot: true,
                    rightDotColor: Colors.black,
                    rightDotSize: 14,
                    rightDotBorderWidth: 2,
                    keyboardType: TextInputType.text,
                  ),
                  const Gap(10),
                  CustomText(
                    text: 'Order Id',
                    fontSize: screenWidth > 600 ? 18 : 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  const Gap(10),
                  CustomTextField(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 14,
                    ),
                    fillColor: AppColor.white,
                    controller: _locationController,
                    borderColor: AppColor.white,
                    fontStyle: FontStyle.normal,
                    hintText: 'Enter',
                    hintTextColor: AppColor.darkGrayShade,
                    keyboardType: TextInputType.streetAddress,
                  ),
                  const Gap(10),
                  CustomText(
                    text: 'Reason',
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
                    hintText: 'Enter',
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
                  CustomText(
                    text: 'Upload Photos',
                    fontSize: screenWidth > 600 ? 18 : 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  const Gap(10),
                  // Image upload section
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = (constraints.maxWidth - 40) / 3;
                      return Row(
                        children: List.generate(
                          2,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: itemWidth * 1.60,
                              height: itemWidth * 1,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                                color: AppColor.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.svgsIconAwesomeImage,
                                    width: itemWidth * 0.36,
                                    height: itemWidth * 0.28,
                                  ),
                                  const Gap(8),
                                  const CustomText(
                                    text: 'Tap to Upload',
                                    fontSize: 14,
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
                ],
              ),
            ),
          ),
          if (!isKeyboardOpen)
            // Fixed bottom container with submit button
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
                        text: 'Submit Now',
                        onTap: () {},
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
