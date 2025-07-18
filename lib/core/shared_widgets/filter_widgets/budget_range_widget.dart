import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class BudgetRangeWidget extends StatelessWidget {
  const BudgetRangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Assets.svgsTargetBudget,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            const CustomText(
              text: 'Budget Range',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() => Row(
              children: [
                Text(
                  '\$${controller.minBudget.value.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 14, color: AppColor.midGray),
                ),
                Expanded(
                  child: RangeSlider(
                    values: RangeValues(
                        controller.minBudget.value, controller.maxBudget.value),
                    min: 0,
                    max: 2000,
                    divisions: 40,
                    activeColor: AppColor.mutedGold,
                    inactiveColor: AppColor.lightGray,
                    onChanged: (RangeValues values) {
                      controller.updateBudgetRange(values.start, values.end);
                    },
                  ),
                ),
                Text(
                  '\$${controller.maxBudget.value.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 14, color: AppColor.midGray),
                ),
              ],
            )),
      ],
    );
  }
}
