part of 'config.dart';

class AppRouter {
  List<GetPage> get getPages => [
        GetPage(
          name: AppRoutes.splash,
          page: () => const SplashScreen(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: AppRoutes.onboarding,
          page: () => const OnboardingScreen(),
          binding: OnBoardingBinding(),
        ),
        GetPage(
          name: AppRoutes.mainPageWithNavBar,
          page: () => const MainPageWithNavbar(),
          binding: MainPageWithNavBarBinding(),
        ),
        GetPage(
          name: AppRoutes.login,
          page: () => const LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: AppRoutes.register,
          page: () => const CreateAccountScreen(),
          binding: CreateAccountBinding(),
        ),
        GetPage(
          name: AppRoutes.verifyEmail,
          page: () => const VerifyEmailScreen(),
          binding: VerifyEmailBinding(),
        ),
        GetPage(
          name: AppRoutes.selectRole,
          page: () => const SelectRoleScreen(),
          binding: SelectRoleBinding(),
        ),
        GetPage(
          name: AppRoutes.profileSetup,
          page: () {
            final arguments = Get.arguments as Map<String, dynamic>?;
            final role = arguments?['role'] as String?;
            return ProfileSetupScreen(role: role);
          },
          binding: SelectRoleBinding(),
        ),
        GetPage(
          name: AppRoutes.homePage,
          page: () => const HomePage(),
          binding: HomePageBinding(),
        ),
        GetPage(
          name: AppRoutes.jobPost,
          page: () => const JobPostPage(),
          binding: JobPostBinding(),
        ),
        GetPage(
          name: AppRoutes.jobRequest,
          page: () {
            // Retrieve the arguments
            final args = Get.arguments as Map<String, dynamic>?;
            return JobRequestPage(
              initialTitle: args?['initialTitle'] as String?,
              subcontractor: args?[
                  'subcontractor'], // Fixed: use args instead of Get.arguments
            );
          },
        ),
        GetPage(
          name: AppRoutes.inviteSubcontractorPage,
          page: () => SubcontractorsPage(),
          binding: SubcontractorPageBinding(),
        ),
        GetPage(
          name: AppRoutes.jobHistory,
          page: () => const JobHistoryPage(),
          binding: JobHistoryPageBinding(),
        ),
        GetPage(
          name: AppRoutes.profilePage,
          page: () => ProfileScreen(),
          binding: ProfilePageBinding(),
        ),
        GetPage(
          name: AppRoutes.myAccountPage,
          page: () => const MyAccountPage(),
          binding: MyAccountPageBinding(),
        ),
        GetPage(
          name: AppRoutes.notificationPage,
          page: () => NotificationPage(),
          binding: NotificationPageBinding(),
        ),
        GetPage(
          name: AppRoutes.subcontractornotificationPage,
          page: () => SubcontractorNotificationPage(),
          binding: SubcontractorNotificationPageBinding(),
        ),
        GetPage(
          name: AppRoutes.mediationProcess,
          page: () => const MediationProcessPage(),
          binding: MediationProcessPageBinding(),
        ),
        GetPage(
          name: AppRoutes.favoritesSubcontractor,
          page: () => const FavoritesSubcontractorPage(),
          binding: FavoritesSubcontractorPageBinding(),
        ),
        GetPage(
          name: AppRoutes.uploadProgress,
          page: () => const UploadProgressPage(),
          binding: UploadProgressPageBinding(),
        ),
        GetPage(
          name: AppRoutes.subcontractorJob,
          page: () {
            // Access the arguments passed via Get.toNamed
            final args = Get.arguments as Map<String, dynamic>?;
            // Extract isFromAcceptJob, default to false if not provided
            final isFromAcceptJob = args?['isFromAcceptJob'] as bool? ?? false;
            return SubcontractorJobPage(isFromAcceptJob: isFromAcceptJob);
          },
          binding: SubcontractorJobPageBinding(),
        ),
        GetPage(
          name: AppRoutes.subcontractorJobHistory,
          page: () => const SubcontractorJobHistoryPage(),
          binding: SubcontractorJobHistoryPageBinding(),
        ),
        GetPage(
          name: AppRoutes.subcontractorJobHistoryDetail,
          page: () {
            final args = Get.arguments as Map<String, dynamic>?;
            final job = args?['job'];
            final isOpenJob = args?['isOpenJob'] as bool? ?? false;
            return SubcontractorJobHistoryDetailPage(
              job: job,
              isOpenJob: isOpenJob,
            );
          },
        ),
        GetPage(
          name: AppRoutes.subcontractorFeedbackPage,
          page: () => const SubcontractorFeedbackPage(),
          binding: SubcontractorFeedbackPageBinding(),
        ),
        GetPage(
          name: AppRoutes.subcontractorProfilePage,
          page: () => const SubcontractorProfilePage(),
          binding: SubcontractorProfilePageBinding(),
        ),
        GetPage(
          name: AppRoutes.subcontractorMyAccountPage,
          page: () => const SubcontractorMyaccountPage(),
          binding: SubcontractorMyAccountPageBinding(),
        ),
        GetPage(
          name: AppRoutes.chatDetailPage,
          page: () {
            final args = Get.arguments as Map<String, dynamic>?;
            final userName = args?['userName'] as String? ?? 'User';
            final avatarImage =
                args?['avatarImage'] as String? ?? Assets.imagesChatMichael;
            return ChatDetailPage(
              userName: userName,
              avatarImage: avatarImage,
            );
          },
        ),
        GetPage(
          name: AppRoutes.subcontractorPage,
          page: () => const FavSubcontractorPage(),
          binding: SubcontractorFavPageBinding(),
        ),
        GetPage(
          name: AppRoutes.supportRequests,
          page: () => SupportRequestPage(),
          binding: SupportRequestPageBinding(),
        ),
        GetPage(
          name: AppRoutes.changePassword,
          page: () => const ChangePasswordPage(),
          binding: ChangePasswordPageBinding(),
        ),
        GetPage(
          name: AppRoutes.newJobs,
          page: () => NewJobsPage(),
          binding: NewJobsPageBinding(),
        ),
        GetPage(
          name: AppRoutes.favSubcontractorProfile,
          page: () => const FavSubcontractorProfile(),
          binding: FavSubcontractorProfileBinding(),
        ),
        GetPage(
          name: AppRoutes.summaryDetailPage,
          page: () => const SummaryDetailPage(),
          binding: SummaryDetailPageBinding(),
        ),
        GetPage(
          name: AppRoutes.propertyManagerProfile,
          page: () => const PropertyManagerProfilePage(),
        ),
        GetPage(
          name: AppRoutes.portfolioPage,
          page: () => const PortfolioPage(),
        ),
        GetPage(
          name: AppRoutes.onBoardingScreen,
          page: () => const OnboardingPage(),
        ),
      ];
}
