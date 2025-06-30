import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/navigation_controller.dart';
import 'package:subtap/core/shared_widgets/custom_navbar.dart';
import 'package:subtap/core/shared_widgets/subtap_scaffold.dart';

class MainPageWithNavbar extends StatelessWidget {
  const MainPageWithNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = NavigationController.to;

    return WillPopScope(
      onWillPop: () async {
        // Check if the current page is not the HomePage (index 0)
        if (navController.currentIndex.value != 0) {
          // Navigate to HomePage by setting index to 0
          navController.changePage(0);
          return false; // Prevent default back navigation
        } else {
          // Show confirmation dialog when on HomePage
          bool? shouldExit = await _showExitConfirmationDialog(context);
          if (shouldExit == true) {
            // Exit the app
            return true;
          }
          return false; // Prevent default back navigation
        }
      },
      child: Obx(
        () => SubtapScaffold(
          body: navController.currentPages.elementAt(
            navController.currentIndex.value,
          ),
          bottomNavigationBar: const CustomNavBar(),
        ),
      ),
    );
  }

  // Function to show exit confirmation dialog
  Future<bool?> _showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false), // No, stay in app
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true), // Yes, exit app
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
