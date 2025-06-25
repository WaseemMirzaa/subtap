part of 'pages.dart';

class UploadProgressPage extends StatefulWidget {
  const UploadProgressPage({super.key});

  @override
  State<UploadProgressPage> createState() => _UploadProgressPageState();
}

class _UploadProgressPageState extends State<UploadProgressPage> {
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
      appBar: const UploadProgressAppbar(),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Notes',
                    fontSize: screenWidth > 600 ? 18 : 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  const Gap(5),
                  CustomTextField(
                    fontStyle: FontStyle.normal,
                    fillColor: AppColor.white,
                    controller: _titleController,
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
                  kGap20,
                  CustomText(
                    text: 'Updates',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CustomText(
                    text: 'Photos(Before and after work) ',
                    fontSize: screenWidth > 600 ? 18 : 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  const Gap(5),
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
                        text: 'Submit Progress for Mark as Complete',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const JobVerificationPage(
                                job: JobHistory(
                                  title: 'Electrical & Tech',
                                  svgIcon: Assets.svgsTech,
                                  price: 65.0,
                                  targetBudget: '\$50.00',
                                  dueDate: 'Friday, May 23, 2025',
                                  address: '456 Oak Ave, Springfield',
                                  status: 'Active Jobs',
                                  description:
                                      "I hope you're well.I'm looking to get some carpentry & \n Farming work done and wanted to see if you're avaiable.\n Please let me know.",
                                  subcontractorModel: SubcontractorModel(
                                    expertise: 'Electrician',
                                    description:
                                        'Leaking kitchen sink, Pipe may be cracked. Water \n dripping into cabinet below. Happened after turning on garbage disposal.',
                                    name: 'James Michael',
                                    imageUrl: 'path_to_image',
                                    price: '50.00',
                                    rating: 4.0,
                                  ),
                                ),
                              ),
                            ),
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
