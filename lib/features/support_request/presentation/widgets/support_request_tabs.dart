import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/support_request_controller.dart';
import 'package:subtap/core/theme/app_color.dart';

class SupportRequestTabs extends StatelessWidget {
  const SupportRequestTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportRequestController>(
      init: SupportRequestController(),
      builder: (controller) {
        return Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.tabs.length,
            itemBuilder: (context, index) {
              final tab = controller.tabs[index];

              return Obx(() {
                final isSelected = controller.selectedTab.value == tab;

                return GestureDetector(
                  onTap: () => controller.changeTab(tab),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColor.mutedGold : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? AppColor.mutedGold
                            : AppColor.lightGray,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        tab,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppColor.midGray,
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        );
      },
    );
  }
}
