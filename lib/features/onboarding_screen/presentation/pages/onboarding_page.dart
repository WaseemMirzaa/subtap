import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/config/config.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool termsAccepted = false;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      title: "Find Jobs Near You",
      description:
          "Browse and apply for construction jobs in your area. Get notified when new opportunities match your skills.",
      image: Assets.imagesLogo,
    ),
    OnboardingData(
      title: "Showcase Your Work",
      description:
          "Build your portfolio with photos of completed projects. Let property managers see your quality work.",
      image: Assets.imagesLogo,
    ),
    OnboardingData(
      title: "Get Hired Faster",
      description:
          "Connect directly with property managers. Submit proposals and start working on projects you love.",
      image: Assets.imagesLogo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _skipOnboarding(),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: AppColor.midGray,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(onboardingPages[index]);
                },
              ),
            ),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingPages.length,
                (index) => _buildPageIndicator(index),
              ),
            ),

            const SizedBox(height: 32),

            // Terms acceptance (only on last page) - Make sure this shows
            if (currentPage == onboardingPages.length - 1) ...[
              _buildTermsAcceptance(),
              const SizedBox(height: 16),
            ],

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  if (currentPage > 0)
                    Expanded(
                      child: CustomButton(
                        onTap: _previousPage,
                        text: 'Previous',
                        color: Colors.transparent,
                        textColor: AppColor.mutedGold,
                        radius: 25,
                        height: 50,
                      ),
                    ),
                  if (currentPage > 0) const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      onTap: currentPage == onboardingPages.length - 1
                          ? (termsAccepted ? _finishOnboarding : null)
                          : _nextPage,
                      text: currentPage == onboardingPages.length - 1
                          ? 'Get Started'
                          : 'Next',
                      color: (currentPage == onboardingPages.length - 1 &&
                              !termsAccepted)
                          ? AppColor.lightGray
                          : AppColor.mutedGold,
                      textColor: Colors.white,
                      radius: 25,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Image.asset(
            data.image,
            height: 250,
            width: 250,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 48),

          // Title
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            data.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.midGray,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: currentPage == index ? AppColor.mutedGold : AppColor.lightGray,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _nextPage() {
    if (currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    Get.offAllNamed(AppRoutes.mainPageWithNavBar);
  }

  void _finishOnboarding() {
    Get.offAllNamed(AppRoutes.mainPageWithNavBar);
  }

  Widget _buildTermsAcceptance() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Text(
              'I agree to the Terms of Service, Privacy Policy and Data Rights',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.black,
                height: 1.4,
              ),
            ),
          ),
          Checkbox(
            value: termsAccepted,
            onChanged: (value) {
              setState(() {
                termsAccepted = value ?? false;
              });
            },
            activeColor: AppColor.mutedGold,
            checkColor: Colors.white,
            side: const BorderSide(
              color: AppColor.midGray,
              width: 2,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  // Removed _showTermsDialog and _getTermsContent methods
}

class OnboardingData {
  final String title;
  final String description;
  final String image;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}
