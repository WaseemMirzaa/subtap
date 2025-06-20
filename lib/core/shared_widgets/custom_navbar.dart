import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/navigation_controller.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = NavigationController.to;

    return Obx(() {
      // SVG icons for navigation
      final isPropertyManager = navController.isPropertyManager.value;
      final icons = isPropertyManager
          ? [
              Assets.svgsHome,
              Assets.svgsDetails,
              // Exclude Assets.svgsFav for subcontractors
              Assets.svgsMsg,
              Assets.svgsProfile,
            ]
          : [
              Assets.svgsHome,
              Assets.svgsDetails,
              Assets.svgsFav,
              Assets.svgsMsg,
              Assets.svgsProfile,
            ];

      return SizedBox(
        height: 78, // Reduced height (standard is usually 56-60)
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColor.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: BottomNavigationBar(
                  items: _buildNavItems(
                    icons,
                    navController.currentIndex.value,
                  ),
                  currentIndex: navController.currentIndex.value,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: navController.changePage,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
            ),
            // Top border indicator - now with reduced width
          ],
        ),
      );
    });
  }

  List<BottomNavigationBarItem> _buildNavItems(
    List<String> icons,
    int currentIndex,
  ) {
    return icons.map((iconPath) {
      final index = icons.indexOf(iconPath);
      final isSelected = currentIndex == index;

      return BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.only(top: 6), // Reduced padding
          child: SvgPicture.asset(
            iconPath,
            width: 22, // Slightly smaller icons
            height: 22,
            color: isSelected ? AppColor.mutedGold : Colors.grey,
          ),
        ),
        label: '',
      );
    }).toList();
  }
}
