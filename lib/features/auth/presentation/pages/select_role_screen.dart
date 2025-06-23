import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

import '../../../../controller/select_role_controller.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectRoleController());

    return Scaffold(
      backgroundColor: AppColor.lightGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.backColor),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
            text: 'Select Your Role', color: AppColor.backColor, fontSize: 18),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 255,
              child: _RoleCard(
                title: 'Property Manager (PM)',
                onTap: () =>
                    controller.selectRoleAndNavigate('PropertyManager'),
                icon: Assets.imagesPropertyManager,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 255,
              child: _RoleCard(
                title: 'Subcontractor (Sub)',
                onTap: () => controller.selectRoleAndNavigate('Subcontractor'),
                icon: Assets.imagesSubcontractor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String icon;

  const _RoleCard({
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: 160,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  width: 64,
                  height: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColor.backColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'HelveticaNeueMedium',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
