import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class JobTypeWidget extends StatelessWidget {
  const JobTypeWidget({super.key});

  static const List<String> jobTypes = ['Proposal', 'Fixed', 'Hourly'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Assets.svgsTrade,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            const CustomText(
              text: 'Job Type',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColor.lightGray,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.white),
          ),
          child: DropdownButtonHideUnderline(
            child: Obx(() => DropdownButton2<String>(
                  isExpanded: true,
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down,
                        color: AppColor.darkGrayShade, size: 24),
                    openMenuIcon: Icon(Icons.keyboard_arrow_up,
                        color: AppColor.mutedGold, size: 24),
                  ),
                  hint: const CustomText(
                    text: 'Select job type',
                    fontSize: 14,
                    color: AppColor.midGray,
                  ),
                  value: controller.selectedJobType.value,
                  items: jobTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(
                            fontSize: 14, color: AppColor.darkGrayShade),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    controller.updateJobType(value);
                  },
                )),
          ),
        ),
      ],
    );
  }
}
