import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';

class RadiusSliderWidget extends StatelessWidget {
  const RadiusSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Search Radius',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.black,
        ),
        const SizedBox(height: 8),
        Obx(() => Column(
          children: [
            Text(
              'Showing jobs within ${controller.radius.value.toInt()} miles',
              style: const TextStyle(
                fontSize: 14,
                color: AppColor.midGray,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColor.mutedGold,
                inactiveTrackColor: AppColor.lightGray,
                thumbColor: AppColor.mutedGold,
                overlayColor: AppColor.mutedGold.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                trackHeight: 4,
              ),
              child: Slider(
                value: controller.radius.value,
                min: 1,
                max: 100,
                divisions: 99,
                onChanged: (value) => controller.updateRadius(value),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1 mile',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.midGray,
                  ),
                ),
                Text(
                  '100 miles',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.midGray,
                  ),
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }
}