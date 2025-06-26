import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/theme/app_color.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  int? _selectedRating;
  double _radius = 5.0; // Default radius in miles/kilometers
  String? _selectedCategory; // Track selected category

  // List of all categories
  final List<String> _allCategories = [
    'Electrician',
    'Plumber',
    'Mechanic',
    'Carpenter',
    'Painter',
    'Cleaner',
    'Gardener',
    'Chef',
    'Tutor',
    'Photographer',
    'Barber',
    'Tailor',
    'Driver',
    'Delivery',
    'Repair Service',
  ];

  List<String> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCategories = _allCategories;
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _zipCodeController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredCategories = _allCategories;
      } else {
        _filteredCategories = _allCategories
            .where((category) => category
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
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
                          child: const Icon(
                            Icons.remove,
                            size: 20,
                            color: AppColor.midGray,
                          ),
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
                          child: const Icon(
                            Icons.add,
                            size: 20,
                            color: AppColor.midGray,
                          ),
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
                                ? AppColor.mutedGold
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

                  // Searchable Dropdown
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
                        // Customize the dropdown arrow icon
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColor.darkGrayShade,
                            size: 24,
                          ),
                          openMenuIcon: Icon(
                            Icons.keyboard_arrow_up,
                            color: AppColor.mutedGold,
                            size: 24,
                          ),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColor.mutedGold,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                        // Customize menu item style
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 14),
                        ),
                        hint: const Text(
                          'Search by Category',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.mediumGray,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        value: _selectedCategory,
                        // Generate dropdown items from filtered categories
                        items: _filteredCategories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category.toLowerCase(),
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColor.darkGrayShade,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        // Add search functionality
                        dropdownSearchData: DropdownSearchData(
                          searchController: _searchController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              style:
                                  const TextStyle(color: AppColor.mediumGray),
                              expands: true,
                              maxLines: null,
                              controller: _searchController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search categories...',
                                hintStyle: const TextStyle(
                                  fontSize: 12,
                                  color: AppColor.mediumGray,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColor.lightGray,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColor.mutedGold,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  size: 16,
                                  color: AppColor.mediumGray,
                                ),
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
                        // Clear search when dropdown closes
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            _searchController.clear();
                          }
                        },
                      ),
                    ),
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
                        print('Selected Category: $_selectedCategory');
                        print('Location: ${_zipCodeController.text}');
                        print('Radius: $_radius km');
                        print('Rating: $_selectedRating');
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
