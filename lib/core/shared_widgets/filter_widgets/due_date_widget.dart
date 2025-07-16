import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class DueDateWidget extends StatelessWidget {
  const DueDateWidget({super.key});

  static const List<String> dueDateOptions = [
    'This Week',
    'Next 7 Days',
    'Next 30 Days',
    'Custom Date'
  ];

  Future<void> _showCustomDatePicker(BuildContext context) async {
    final controller = Get.find<FilterController>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('MMM dd, yyyy').format(picked);
      controller.updateDueDate(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Assets.svgsTime,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            const CustomText(
              text: 'Due Date',
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
                    text: 'Select due date',
                    fontSize: 14,
                    color: AppColor.midGray,
                  ),
                  value: controller.selectedDueDate.value,
                  items: dueDateOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(
                        option,
                        style: const TextStyle(
                            fontSize: 14, color: AppColor.darkGrayShade),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) async {
                    if (value == 'Custom Date') {
                      await _showCustomDatePicker(context);
                    } else {
                      controller.updateDueDate(value);
                    }
                  },
                )),
          ),
        ),
      ],
    );
  }
}
