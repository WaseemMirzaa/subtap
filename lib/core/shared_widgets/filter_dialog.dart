import 'package:flutter/material.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/theme/app_color.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  _FilterBottomSheetState createState() =>
      _FilterBottomSheetState(); // Fixed here
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  int? _selectedRating;
  double _radius = 5.0; // Default radius in miles/kilometers

  @override
  void dispose() {
    _zipCodeController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  double _getBottomInset(BuildContext context) {
    // Get the bottom inset (keyboard height)
    return MediaQuery.of(context).viewInsets.bottom;
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the height based on keyboard visibility
    final double keyboardHeight = _getBottomInset(context);
    final double baseHeight =
        MediaQuery.of(context).size.height * 0.7; // Base height of bottom sheet
    final double totalHeight = baseHeight + keyboardHeight;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Animation duration
      curve: Curves.easeInOut, // Animation curve
      height: totalHeight, // Adjust height dynamically
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColor.darkGrayShade,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Location Label
                  const CustomText(
                    text: 'Location',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                  const SizedBox(height: 6),

                  // Location TextField
                  CustomTextField(
                    fillColor: AppColor.lightGray,
                    controller: _zipCodeController,
                    borderColor: AppColor.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 14,
                    ),
                    borderRadius: 10,
                    height: 45,
                    hintText: 'Enter your location',
                    fontStyle: FontStyle.normal,
                    hintTextColor: AppColor.darkGrayShade,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Decrease Button
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_radius > 1) {
                              _radius -= 1;
                            }
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.lightGray,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.remove, size: 20),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Radius Value
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColor.lightGray.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_radius.toStringAsFixed(0)} km',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: AppColor.grayShade,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Increase Button
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_radius < 100) {
                              _radius += 1;
                            }
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.lightGray,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Custom Divider
                  Container(
                    height: 1,
                    color: AppColor.lightGray,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  // Rating Label
                  const CustomText(
                    text: 'Ratings',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                  const SizedBox(height: 8),

                  // Star Rating Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(5, (index) {
                      final rating = index + 1;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRating =
                                rating == _selectedRating ? null : rating;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedRating == rating
                                ? AppColor.grayShade
                                : AppColor.lightGray,
                            border: Border.all(color: AppColor.lightGray),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$rating Star',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _selectedRating == rating
                                  ? AppColor.black
                                  : AppColor.darkGrayShade,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),

                  // Categories Label
                  const CustomText(
                    text: 'Categories',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                  const SizedBox(height: 8),

                  // Categories TextField
                  CustomTextField(
                    fillColor: AppColor.lightGray,
                    controller: _categoryController,
                    borderColor: AppColor.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 14,
                    ),
                    borderRadius: 10,
                    height: 45,
                    hintText: 'Search by Category',
                    fontStyle: FontStyle.normal,
                    hintTextColor: AppColor.darkGrayShade,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 90), // Space for bottom button
                ],
              ),
            ),
          ),

          // Positioned button container at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 95,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColor.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Show Results',
                      onTap: () {
                        // Handle filter application
                      },
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
  }
}
