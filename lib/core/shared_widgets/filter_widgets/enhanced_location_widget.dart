import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class EnhancedLocationWidget extends StatelessWidget {
  const EnhancedLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Location',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.black,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                fillColor: AppColor.lightGray,
                controller: controller.locationController,
                borderColor: AppColor.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 9, horizontal: 14),
                borderRadius: 10,
                height: 45,
                hintText: 'Enter city or ZIP code',
                hintStyle: const TextStyle(color: AppColor.midGray),
                fontStyle: FontStyle.normal,
                hintTextColor: AppColor.darkGrayShade,
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Assets.svgsLocation,
                    color: AppColor.midGray,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Obx(() => InkWell(
              onTap: () => controller.toggleCurrentLocation(!controller.useCurrentLocation.value),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: controller.useCurrentLocation.value 
                      ? AppColor.mutedGold 
                      : AppColor.lightGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.my_location,
                      size: 16,
                      color: controller.useCurrentLocation.value 
                          ? Colors.white 
                          : AppColor.midGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Use My Location',
                      style: TextStyle(
                        fontSize: 12,
                        color: controller.useCurrentLocation.value 
                            ? Colors.white 
                            : AppColor.midGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ],
    );
  }
}