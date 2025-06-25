part of 'widgets.dart';

class JobVerificationBottomSheet extends StatefulWidget {
  const JobVerificationBottomSheet({super.key});

  @override
  State<JobVerificationBottomSheet> createState() =>
      _JobVerificationBottomSheetState();
}

class _JobVerificationBottomSheetState
    extends State<JobVerificationBottomSheet> {
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    // Auto-focus on first input field when bottom sheet opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Verify Code',
                onTap: () {
                  // Check if all fields are filled
                  String code = controllers.map((c) => c.text).join();
                  if (code.length == 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Verifying code...')),
                    );
                    Get.toNamed(AppRoutes.subcontractorFeedbackPage);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter complete 4-digit code'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                color: AppColor.mutedGold,
                textColor: Colors.white,
                fontWeight: FontWeight.w400,
                radius: 17,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleTextChange(int index, String value) {
    if (value.isNotEmpty) {
      // Move to next field
      if (index < 3) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        // All fields filled, dismiss keyboard
        FocusScope.of(context).unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      // Move to previous field when backspace is pressed
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate dynamic height based on keyboard state
    final defaultHeight = screenHeight * 0.45; // Default height (45% of screen)
    final expandedHeight =
        screenHeight * 0.65; // Expanded height when keyboard is open

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: isKeyboardOpen ? expandedHeight : defaultHeight,
      decoration: const BoxDecoration(
        color: AppColor.lightGray,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag indicator
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColor.midGray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Job Verification',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                    fontFamily: 'HelveticaNeueMedium',
                  ),
                  kGap10,
                  const CustomText(
                    text: 'Enter 4-digit Completion Code',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.midGray,
                    fontFamily: 'HelveticaNeueMedium',
                  ),
                  const SizedBox(height: 25),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: 57,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(0, 2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          maxLength: 1,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                          onChanged: (value) => handleTextChange(index, value),
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Resend Code
                  GestureDetector(
                    onTap: () {
                      // Clear all fields
                      for (var controller in controllers) {
                        controller.clear();
                      }
                      // Focus on first field
                      focusNodes[0].requestFocus();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Verification code resent successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.mutedGold,
                          fontFamily: 'HelveticaNeueMedium',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  // Add extra space when keyboard is open to ensure content is visible
                  if (isKeyboardOpen) const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Bottom action bar - only show when keyboard is closed
          if (!isKeyboardOpen) _buildBottomActionBar(context),
        ],
      ),
    );
  }
}
