import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/budget_range_widget.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/due_date_widget.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/job_type_widget.dart';
import 'package:subtap/core/shared_widgets/filter_widgets/invited_jobs_widget.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColor.lightGray,
      margin: const EdgeInsets.symmetric(vertical: 16),
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
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColor.darkGrayShade,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location Section
                      const CustomText(
                        text: 'Location',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                      const SizedBox(height: 6),
                      CustomTextField(
                        fillColor: AppColor.lightGray,
                        controller: controller.zipCodeController,
                        borderColor: AppColor.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 14),
                        borderRadius: 10,
                        height: 45,
                        hintText: 'Enter your location',
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

                      // Radius Section
                      const SizedBox(height: 16),
                      Obx(() => Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (controller.radius.value > 1) {
                                    controller.updateRadius(
                                        controller.radius.value - 1);
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightGray,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.remove,
                                      size: 20, color: AppColor.midGray),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightGray
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${controller.radius.value.toStringAsFixed(0)} miles',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: AppColor.grayShade,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  if (controller.radius.value < 100) {
                                    controller.updateRadius(
                                        controller.radius.value + 1);
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightGray,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.add,
                                      size: 20, color: AppColor.midGray),
                                ),
                              ),
                            ],
                          )),

                      _buildDivider(),

                      // Budget Range Widget
                      const BudgetRangeWidget(),

                      _buildDivider(),

                      // Due Date Widget
                      const DueDateWidget(),

                      _buildDivider(),

                      // Job Type Widget
                      const JobTypeWidget(),

                      _buildDivider(),

                      // Invited Jobs Widget
                      const InvitedJobsWidget(),

                      _buildDivider(),

                      // Rating Section
                      const CustomText(
                        text: 'Minimum Rating',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                      const SizedBox(height: 8),
                      Obx(() => RatingBar.builder(
                            initialRating: controller.minRating.value,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 26,
                            ignoreGestures: false,
                            unratedColor: AppColor.ghostGrey,
                            itemBuilder: (context, _) => const Icon(Icons.star,
                                color: AppColor.vibrantYellow),
                            onRatingUpdate: (rating) {
                              controller.updateRating(rating);
                            },
                          )),

                      _buildDivider(),

                      // Categories Section
                      const CustomText(
                        text: 'Categories',
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
                        child: Obx(() => DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                iconStyleData: const IconStyleData(
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: AppColor.darkGrayShade, size: 24),
                                  openMenuIcon: Icon(Icons.keyboard_arrow_up,
                                      color: AppColor.mutedGold, size: 24),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColor.mutedGold, width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.symmetric(horizontal: 14),
                                ),
                                hint: const CustomText(
                                    text: 'Select category',
                                    fontSize: 14,
                                    color: AppColor.midGray),
                                value: controller.selectedCategory.value,
                                items: controller.filteredCategories
                                    .map((String category) {
                                  return DropdownMenuItem<String>(
                                    value: category.toLowerCase(),
                                    child: Text(
                                      category,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColor.darkGrayShade),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  controller.updateCategory(value);
                                },
                                dropdownSearchData: DropdownSearchData(
                                  searchController: controller.searchController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 4, right: 8, left: 8),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          color: AppColor.mediumGray),
                                      expands: true,
                                      maxLines: null,
                                      controller: controller.searchController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                        hintText: 'Search categories...',
                                        hintStyle: const TextStyle(
                                            fontSize: 12,
                                            color: AppColor.mediumGray),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: AppColor.lightGray),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: AppColor.mutedGold),
                                        ),
                                        prefixIcon: const Icon(Icons.search,
                                            size: 16,
                                            color: AppColor.mediumGray),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchValue.toLowerCase());
                                  },
                                ),
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    controller.searchController.clear();
                                  }
                                },
                              ),
                            )),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Bottom buttons
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Reset',
                          onTap: () => controller.resetFilters(),
                          color: AppColor.lightGray,
                          textColor: AppColor.black,
                          fontWeight: FontWeight.w400,
                          radius: 17,
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: CustomButton(
                          text: 'Show Results',
                          onTap: () => controller.applyFilters(),
                          color: AppColor.mutedGold,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w400,
                          radius: 17,
                        ),
                      ),
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
