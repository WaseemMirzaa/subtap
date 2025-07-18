import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/enhanced_location_widget.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/radius_slider_widget.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/enhanced_rating_widget.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/enhanced_categories_widget.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/budget_range_widget.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/invited_jobs_widget.dart';
import 'package:subtap/core/theme/app_color.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColor.lightGray,
      margin: const EdgeInsets.symmetric(vertical: 16),
    );
  }

  Widget _buildDropdownSection({
    required String title,
    required String? value,
    required List<String> options,
    required Function(String?) onChanged,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.black,
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
            child: DropdownButton2<String>(
              isExpanded: true,
              value: value,
              hint: Text(
                hint ?? 'Select $title',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColor.midGray,
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down,
                    color: AppColor.darkGrayShade, size: 24),
                openMenuIcon: Icon(Icons.keyboard_arrow_up,
                    color: AppColor.mutedGold, size: 24),
              ),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColor.darkGrayShade,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());

    return LayoutBuilder(
      builder: (context, constraints) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final screenHeight = MediaQuery.of(context).size.height;
        final maxHeight = screenHeight * 0.9;
        final minHeight = screenHeight * 0.6;
        final calculatedHeight = (screenHeight * 0.8) + keyboardHeight;
        final finalHeight = calculatedHeight.clamp(minHeight, maxHeight);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: finalHeight,
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header with drag handle and reset button
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColor.darkGrayShade,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.resetFilters(),
                      child: const Text(
                        'Reset Filters',
                        style: TextStyle(
                          color: AppColor.mutedGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Enhanced Location Section
                      const EnhancedLocationWidget(),

                      _buildDivider(),

                      // Radius Slider
                      const RadiusSliderWidget(),

                      _buildDivider(),

                      // Enhanced Categories
                      const EnhancedCategoriesWidget(),

                      _buildDivider(),

                      // Budget Range
                      const BudgetRangeWidget(),

                      _buildDivider(),

                      // Enhanced Rating
                      const EnhancedRatingWidget(),

                      _buildDivider(),

                      // Posted Date
                      Obx(() => _buildDropdownSection(
                            title: 'Posted Date',
                            value: controller.selectedPostedDate.value,
                            options: controller.postedDateOptions,
                            onChanged: controller.updatePostedDate,
                            hint: 'Any time',
                          )),

                      _buildDivider(),

                      // Job Type
                      Obx(() => _buildDropdownSection(
                            title: 'Job Type',
                            value: controller.selectedJobType.value,
                            options: controller.jobTypeOptions,
                            onChanged: controller.updateJobType,
                            hint: 'All types',
                          )),

                      _buildDivider(),

                      // Time Required
                      Obx(() => _buildDropdownSection(
                            title: 'Time Required',
                            value: controller.selectedTimeRequired.value,
                            options: controller.timeRequiredOptions,
                            onChanged: controller.updateTimeRequired,
                            hint: 'Any duration',
                          )),

                      _buildDivider(),

                      // Invited Jobs Toggle
                      const InvitedJobsWidget(),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Bottom section with job count and apply button
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  border: Border(
                    top: BorderSide(color: AppColor.lightGray, width: 1),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${controller.matchingJobsCount} jobs match your filters',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.midGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(() => CustomButton(
                            text: controller.isLoading.value
                                ? 'Loading...'
                                : 'Show Results',
                            onTap: controller.isLoading.value
                                ? null
                                : () => controller.applyFilters(),
                            color: AppColor.mutedGold,
                            textColor: Colors.white,
                            fontWeight: FontWeight.w600,
                            radius: 12,
                            isLoading: controller.isLoading.value,
                            loadingColor: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
