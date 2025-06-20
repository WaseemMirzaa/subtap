part of 'pages.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  Widget _buildTipButton(String amount, double width) {
    return SizedBox(
      width: width,
      height: 48,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: Text(
            amount,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.darkGrayShade,
              fontFamily: 'HelveticaNeueMedium',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SubtapScaffold(
      appBar: const FeedBackAppbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 100, // Extra space for bottom button
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.responsiveHeight(29)),
                Text(
                  'Share Your Experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: context.responsiveFontSize(22),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'HelveticaNeueMedium',
                  ),
                ),
                kGap10,
                Text(
                  'How would you rate your experience today?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(14),
                    fontWeight: FontWeight.w500,
                    color: AppColor.midGray,
                    fontFamily: 'HelveticaNeueMedium',
                  ),
                ),
                SizedBox(height: context.responsiveHeight(2)),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 21,
                  ignoreGestures: true,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: AppColor.vibrantYellow),
                  onRatingUpdate: (rating) {},
                ),
                SizedBox(height: context.responsiveHeight(2)),
                CustomTextField(
                  fillColor: AppColor.white,
                  borderColor: AppColor.white,
                  hintText: 'Please share any comments or suggestions...',
                  fontStyle: FontStyle.normal,
                  hintTextColor: AppColor.mediumGray,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  height: screenHeight * 0.13,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.04,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.responsiveHeight(4)),
                    Text(
                      'Optional tip',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(16),
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                    SizedBox(height: context.responsiveHeight(2)),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final buttonWidth = (constraints.maxWidth - 32) / 5;
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.start,
                          children: [
                            _buildTipButton('£5', buttonWidth),
                            _buildTipButton('£10', buttonWidth),
                            _buildTipButton('£15', buttonWidth),
                            _buildTipButton('£20', buttonWidth),
                            _buildTipButton('Others', buttonWidth),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: context.responsiveHeight(6)),
              ],
            ),
          ),
          // Bottom submit button container
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColor.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: CustomButton(
                text: 'Submit Review & Tip',
                fontSize: 16,
                onTap: () {
                  // Handle submit action
                },
                color: AppColor.mutedGold,
                textColor: Colors.white,
                fontWeight: FontWeight.w400,
                radius: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
