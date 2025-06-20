import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/config/config.dart';
import 'package:subtap/features/chat/presentation/pages/pages.dart';
import 'package:subtap/features/fav_subcontractor/presentation/pages/pages.dart';
import 'package:subtap/features/home/presentation/pages/pages.dart';
import 'package:subtap/features/job_history/presentation/pages/pages.dart';
import 'package:subtap/features/main_page_with_navbar.dart';
import 'package:subtap/features/profile/presentation/pages/pages.dart';
import 'package:subtap/features/subcontractor_home/presentation/pages/pages.dart';
import 'package:subtap/features/subcontractor_job_history/presentation/pages/pages.dart';
import 'package:subtap/features/subcontractor_profile/presentation/pages/pages.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();

  final RxInt currentIndex = 0.obs;
  final RxBool isPropertyManager = false.obs;

  // Different pages for each user type
  final List<Widget> propertyManagerPages = [
    const HomePage(),
    const JobHistoryPage(),
    const FavSubcontractorPage(),
    ChatPage(),
    ProfileScreen()
    // ChatPage(),
    // ProfileScreen(),
  ];

  final List<Widget> subcontractorPages = [
    const SubcontractorHomePage(),
    const SubcontractorJobHistoryPage(),
    ChatPage(),
    SubcontractorProfilePage()
  ];

  void changePage(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;

      // If we're not on the main navigation page, just go back to it
      if (Get.currentRoute != AppRoutes.mainPageWithNavBar) {
        // Use Get.back() to return to the previous page (MainPageWithNavbar)
        // This preserves the existing navbar instance
        Get.back();
      }
    }
  }

  void setUserType(bool isProperty) {
    isPropertyManager.value = isProperty;
    currentIndex.value = 0; // Reset to first tab
  }

  void navigateToMainPage() {
    Get.offAll(() => const MainPageWithNavbar()); // Navigate to main page
  }

  List<Widget> get currentPages =>
      isPropertyManager.value ? subcontractorPages : propertyManagerPages;
}
