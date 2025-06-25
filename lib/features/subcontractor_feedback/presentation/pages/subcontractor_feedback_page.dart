part of 'pages.dart';

class SubcontractorFeedbackPage extends StatelessWidget {
  const SubcontractorFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SubtapScaffold(
      appBar: const SubcontractorFeedbackAppbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.responsiveHeight(40)),
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
                  SizedBox(height: context.responsiveHeight(4)),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 26,
                    ignoreGestures: false, // Enable interaction
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: AppColor.vibrantYellow),
                    onRatingUpdate: (rating) {
                      // Handle rating changes here
                      print('New rating: $rating');
                    },
                  ),
                  SizedBox(height: context.responsiveHeight(2)),
                  CustomTextField(
                    fillColor: AppColor.white,
                    borderColor: AppColor.white,
                    hintText:
                        'Please share any comments or suggestions to help us improve your next visit.',
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
                ],
              ),
            ),
          ),
          // Bottom submit button container
          if (!isKeyboardOpen)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColor.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: CustomButton(
                text: 'Submit Review',
                fontSize: 16,
                onTap: () {
                  NavigationController.to
                      .navigateToMainPage(); // Navigate to MainPageWithNavbar
                  NavigationController.to.changePage(1);
                },
                color: AppColor.mutedGold,
                textColor: Colors.white,
                fontWeight: FontWeight.w400,
                radius: 17,
              ),
            ),
        ],
      ),
    );
  }
}
