part of 'widgets.dart';

void showJobVerificationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.lightGray,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled:
        true, // Allow the bottom sheet to take full height if needed
    builder: (context) => const JobVerificationBottomSheet(),
  );
}

class JobVerificationBottomSheet extends StatelessWidget {
  const JobVerificationBottomSheet({super.key});

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Verify Code',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Verifying code...')),
                );
                Get.toNamed(AppRoutes.subcontractorFeedbackPage);
              },
              color: AppColor.mutedGold,
              textColor: Colors.white,
              fontWeight: FontWeight.w400,
              radius: 17,
              height: 50, // Explicit height for consistency
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.4,
      decoration: const BoxDecoration(
        color: AppColor.lightGray,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Scrollable content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
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
                  kGap15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4, // Changed to 4 for 4-digit code
                      (index) => SizedBox(
                        width: 57,
                        height: 50,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xFF1A1A1A),
                          ),
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kGap15,
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Code resent')),
                      );
                    },
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.midGray,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom action bar
          _buildBottomActionBar(context),
        ],
      ),
    );
  }
}
