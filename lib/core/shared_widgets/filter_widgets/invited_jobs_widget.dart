import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class InvitedJobsWidget extends StatelessWidget {
  const InvitedJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Obx(() => Row(
          children: [
            SvgPicture.asset(
              Assets.svgsFav,
              width: 20,
              height: 20,
              color: AppColor.darkBlueShade,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: CustomText(
                text: 'Show Invited Jobs Only',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
              ),
            ),
            Switch(
              value: controller.showInvitedOnly.value,
              onChanged: (bool value) {
                controller.updateInvitedOnly(value);
              },
              activeColor: AppColor.mutedGold,
              inactiveThumbColor: AppColor.midGray,
              inactiveTrackColor: AppColor.lightGray,
            ),
          ],
        ));
  }
}
