import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';

class EnhancedRatingWidget extends StatelessWidget {
  const EnhancedRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();
    
    final ratingOptions = [
      {'value': 1.0, 'label': '1+ Stars'},
      {'value': 2.0, 'label': '2+ Stars'},
      {'value': 3.0, 'label': '3+ Stars'},
      {'value': 4.0, 'label': '4+ Stars'},
      {'value': 5.0, 'label': '5 Stars Only'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Minimum Rating',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.black,
        ),
        const SizedBox(height: 4),
        const Text(
          'Show jobs from property managers rated at least:',
          style: TextStyle(
            fontSize: 12,
            color: AppColor.midGray,
          ),
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
          child: Obx(() => DropdownButtonHideUnderline(
            child: DropdownButton2<double>(
              isExpanded: true,
              value: controller.minRating.value,
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down,
                    color: AppColor.darkGrayShade, size: 24),
                openMenuIcon: Icon(Icons.keyboard_arrow_up,
                    color: AppColor.mutedGold, size: 24),
              ),
              items: ratingOptions.map((option) {
                return DropdownMenuItem<double>(
                  value: option['value'] as double,
                  child: Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          size: 16,
                          color: index < (option['value'] as double)
                              ? AppColor.vibrantYellow
                              : AppColor.ghostGrey,
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        option['label'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.darkGrayShade,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.updateMinRating(value);
                }
              },
            ),
          )),
        ),
      ],
    );
  }
}