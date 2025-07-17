import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subtap/core/shared_widgets/subtap_scaffold.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/models/models.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/portfolio_appbar.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PortfolioController());

    return SubtapScaffold(
      appBar: const PortfolioAppbar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Header Section
                      _buildProfileHeader(controller),

                      // Skills Badges
                      _buildSkillsBadges(controller),

                      // Availability Toggle
                      _buildAvailabilitySection(controller),

                      // Ratings & Reviews
                      _buildRatingsSection(),

                      // Portfolio Categories
                      _buildCategoriesSection(controller),

                      // Portfolio Grid
                      _buildPortfolioGrid(controller),

                      const SizedBox(height: 80), // Space for FAB
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: controller.uploadPortfolio,
              backgroundColor: AppColor.mutedGold,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(PortfolioController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(Assets.imagesSubcontrctorImage),
          ),
          const SizedBox(height: 12),
          const Text(
            'James Michael',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '5+ years in framing and trim carpentry',
            style: TextStyle(
              fontSize: 14,
              color: AppColor.midGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsBadges(PortfolioController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: controller.skillsBadges.map((skill) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColor.offWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColor.lightGray),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  _getSkillIcon(skill),
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  skill,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAvailabilitySection(PortfolioController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.lightGray),
        ),
        child: Row(
          children: [
            Obx(() => Icon(
                  Icons.calendar_today,
                  color: controller.isOpenForWork.value
                      ? Colors.green
                      : AppColor.midGray,
                  size: 20,
                )),
            const SizedBox(width: 12),
            Expanded(
              child: Obx(() => Text(
                    controller.isOpenForWork.value
                        ? 'Open for Work'
                        : 'Currently Busy',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: controller.isOpenForWork.value
                          ? Colors.green
                          : AppColor.midGray,
                    ),
                  )),
            ),
            Obx(() => Switch(
                  value: controller.isOpenForWork.value,
                  onChanged: (_) => controller.toggleAvailability(),
                  activeColor: AppColor.mutedGold,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text(
                '4.8 (12 reviews)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // Navigate to reviews page
            },
            child: const Text(
              'View All',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.mutedGold,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(PortfolioController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];

          return Obx(() {
            final isSelected = controller.selectedCategory.value == category;

            return GestureDetector(
              onTap: () => controller.changeCategory(category),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.mutedGold : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColor.mutedGold : AppColor.lightGray,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppColor.black,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildPortfolioGrid(PortfolioController controller) {
    return Obx(() {
      final items = controller.filteredItems;

      if (items.isEmpty) {
        return Container(
          height: 200,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.photo_library, size: 64, color: AppColor.lightGray),
                SizedBox(height: 16),
                Text(
                  'No portfolio items yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.midGray,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildPortfolioCard(item, controller);
        },
      );
    });
  }

  Widget _buildPortfolioCard(
      PortfolioItem item, PortfolioController controller) {
    return GestureDetector(
      onTap: () => controller.viewPortfolioItem(item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Delete button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => controller.deletePortfolioItem(item.id),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    // Category badge
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColor.mutedGold,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item.caption,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSkillIcon(String skill) {
    switch (skill.toLowerCase()) {
      case 'drywall':
        return Assets.svgsDrywall;
      case 'electrical':
        return Assets.svgsElectrical;
      case 'framing':
        return Assets.svgsFancing;
      case 'plumbing':
        return Assets.svgsPlumbing;
      case 'painting':
        return Assets.svgsPainting;
      default:
        return Assets.svgsElectrical;
    }
  }
}
