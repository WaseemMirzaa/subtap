import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/filter_controller.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/search_bar_tile.dart';
import 'package:subtap/core/theme/app_color.dart';

class EnhancedCategoriesWidget extends StatelessWidget {
  const EnhancedCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Categories',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.black,
        ),
        const SizedBox(height: 8),

        // Search bar for categories
        SearchBarTile(
          controller: controller.categorySearchController,
          hintText: 'Search categories (e.g., "paint")',
          onSearch: (query) {}, // Already handled by listener in controller
        ),

        const SizedBox(height: 12),

        // Selected categories chips
        Obx(() => controller.selectedCategories.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected:',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.midGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: controller.selectedCategories.map((category) {
                      return Chip(
                        label: Text(
                          category,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: AppColor.mutedGold,
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                        onDeleted: () => controller.removeCategory(category),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
              )
            : const SizedBox()),

        // Available categories
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightGray),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() => ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = controller.filteredCategories[index];
                  final isSelected =
                      controller.selectedCategories.contains(category);

                  return CheckboxListTile(
                    dense: true,
                    title: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.midGray,
                      ),
                    ),
                    value: isSelected,
                    activeColor: AppColor.mutedGold,
                    onChanged: (bool? value) {
                      controller.toggleCategory(category);
                    },
                  );
                },
              )),
        ),
      ],
    );
  }
}
