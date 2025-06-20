part of 'binding.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController(), fenix: true);
    // Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    // Get.lazyPut<UserRepository>(() => UserRepository(), fenix: true);
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Use put instead of lazyPut to ensure immediate initialization
    Get.put<SplashController>(SplashController(), permanent: true);
  }
}

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class CreateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountController>(() => CreateAccountController());
  }
}

class VerifyEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyEmailController>(() => VerifyEmailController());
  }
}

class SelectRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectRoleController>(() => SelectRoleController());
  }
}

class ProfileSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSetupController>(() => ProfileSetupController());
  }
}

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}

class MainPageWithNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}

class JobPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobPostController>(() => JobPostController());
  }
}

class JobRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobRequestPageController>(() => JobRequestPageController());
  }
}

class SubcontractorPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcontractorController>(() => SubcontractorController());
  }
}

class JobHistoryPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobHistoryController>(() => JobHistoryController());
  }
}

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePageController>(() => ProfilePageController());
  }
}

class MyAccountPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyaccountPageController>(() => MyaccountPageController());
  }
}

class NotificationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}

class MediationProcessPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediationProcessPageController>(
        () => MediationProcessPageController());
  }
}

class FavoritesSubcontractorPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesSubcontractorController>(
        () => FavoritesSubcontractorController());
  }
}

class UploadProgressPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadProgressController>(() => UploadProgressController());
  }
}

class SubcontractorJobPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcontractorJobController>(() => SubcontractorJobController());
  }
}

class SubcontractorJobHistoryPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcontrctorJobHistoryController>(
        () => SubcontrctorJobHistoryController());
  }
}

class SubcontractorFeedbackPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcontractorFeedbackController>(
        () => SubcontractorFeedbackController());
  }
}

class SubcontractorProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcontractorProfileController>(
        () => SubcontractorProfileController());
  }
}

class SubcontractorMyAccountPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubcontractorMyaccountController>(
        () => SubcontractorMyaccountController());
  }
}
