import 'package:get/get.dart';
import 'package:subtap/core/config/config.dart';

class OnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;

  void changePage(int page) {
    currentPage.value = page;
  }

  void skipOnboarding() {
    Get.offAllNamed(AppRoutes.mainPageWithNavBar);
  }

  void finishOnboarding() {
    Get.offAllNamed(AppRoutes.mainPageWithNavBar);
  }
}
