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

    return Obx(
      () => SubtapScaffold(
        body: navController.currentPages.elementAt(
          navController.currentIndex.value,
        ),
        bottomNavigationBar: const CustomNavBar(),
      ),
    );
  }
}
