part of 'pages.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Detect if the keyboard is open
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SubtapScaffold(
      appBar: const ChangePasswordAppbar(),
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
                        text: 'Old Password',
                        fontSize: screenWidth > 600 ? 18 : 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                      const Gap(10),
                      // Title Field
                      CustomTextField(
                        fillColor: AppColor.white,
                        controller: _oldPasswordController,
                        borderColor: AppColor.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 9,
                          horizontal: 14,
                        ),
                        borderRadius: 10,
                        height: 45,
                        hintText: 'Enter Old Password',
                        fontStyle: FontStyle.normal,
                        hintTextColor: AppColor.darkGrayShade,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Password';
                          }
                          return null;
                        },
                      ),
                      const Gap(20),

                      CustomText(
                        text: 'New Password',
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
                        controller: _newPasswordController,
                        borderColor: AppColor.white,
                        fontStyle: FontStyle.normal,
                        hintText: 'Enter New Password',
                        hintTextColor: AppColor.darkGrayShade,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new Password';
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      CustomText(
                        text: 'Confirm Password',
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
                        controller: _confirmPasswordController,
                        borderColor: AppColor.white,
                        fontStyle: FontStyle.normal,
                        hintText: 'Enter Confirm Password',
                        hintTextColor: AppColor.darkGrayShade,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                      const Gap(600),
                      // Extra space at the bottom
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
                        text: 'Save Changes',
                        onTap: () {
                          Get.back();
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
