import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/features/subcontractor_portfolio/presentation/pages/portfolio_detail_page.dart';
import 'package:subtap/features/subcontractor_portfolio/presentation/widgets/upload_portfolio_bottom_sheet.dart';
import 'package:subtap/models/models.dart';

class PortfolioController extends GetxController {
  final RxBool isOpenForWork = true.obs;
  final RxString selectedCategory = 'All'.obs;
  final RxList<PortfolioItem> portfolioItems = <PortfolioItem>[].obs;
  final RxBool isLoading = false.obs;

  final List<String> categories = [
    'All',
    'Framing',
    'Electrical',
    'Plumbing',
    'Drywall',
    'Painting',
    'Tile',
    'Flooring'
  ];

  final List<String> skillsBadges = [
    'Drywall',
    'Electrical',
    'Framing',
    'Plumbing',
    'Painting'
  ];

  // Mock data
  @override
  void onInit() {
    super.onInit();
    _loadPortfolioItems();
  }

  void _loadPortfolioItems() {
    portfolioItems.value = [
      PortfolioItem(
        id: '1',
        imageUrl: Assets.imagesPortfolio,
        caption: 'Framing job – done in 3 days',
        category: 'Framing',
        tags: ['Before/After', 'Quick Turnaround'],
        uploadDate: DateTime.now().subtract(const Duration(days: 5)),
      ),
      PortfolioItem(
        id: '2',
        imageUrl: Assets.imagesPortfolio,
        caption: 'Complete electrical rewiring',
        category: 'Electrical',
        tags: ['Safety First', 'Code Compliant'],
        uploadDate: DateTime.now().subtract(const Duration(days: 10)),
      ),
      // Add more mock items...
    ];
  }

  void toggleAvailability() {
    isOpenForWork.value = !isOpenForWork.value;
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  List<PortfolioItem> get filteredItems {
    if (selectedCategory.value == 'All') {
      return portfolioItems;
    }
    return portfolioItems
        .where((item) => item.category == selectedCategory.value)
        .toList();
  }

  void uploadPortfolio() {
    // Handle upload functionality
    Get.bottomSheet(
      const UploadPortfolioBottomSheet(),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void deletePortfolioItem(String id) {
    portfolioItems.removeWhere((item) => item.id == id);
  }

  void viewPortfolioItem(PortfolioItem item) {
    Get.to(() => PortfolioDetailPage(item: item));
  }
}
