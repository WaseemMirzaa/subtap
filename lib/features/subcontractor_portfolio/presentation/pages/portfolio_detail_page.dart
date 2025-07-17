import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';

import 'package:subtap/core/theme/app_color.dart';

import 'package:subtap/core/shared_widgets/subtap_scaffold.dart';
import 'package:subtap/models/models.dart';
import '../controllers/portfolio_controller.dart';

class PortfolioDetailPage extends StatelessWidget {
  final PortfolioItem item;

  const PortfolioDetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.white),
          onPressed: () => Get.back(),
        ),
        title: CustomText(
          text: item.category,
          color: AppColor.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColor.white),
            onPressed: () {
              // Edit portfolio item
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _showDeleteDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Caption
                  Text(
                    item.caption,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Category Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColor.mutedGold,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      item.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Upload Date
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: AppColor.midGray),
                      const SizedBox(width: 8),
                      Text(
                        'Uploaded ${_formatDate(item.uploadDate)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.midGray,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Tags Section
                  if (item.tags.isNotEmpty) ...[
                    const Text(
                      'Tags',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: item.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColor.offWhite,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColor.lightGray),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Project Details Section
                  const Text(
                    'Project Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.lightGray),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow('Category', item.category),
                        const Divider(),
                        _buildDetailRow('Completion Time', '3 days'),
                        const Divider(),
                        _buildDetailRow('Client Rating', '⭐ 5.0'),
                        const Divider(),
                        _buildDetailRow('Project Value', '\$2,500'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description Section
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.lightGray),
                    ),
                    child: const Text(
                      'This project involved complete framing work for a residential property. The work was completed efficiently within the timeline while maintaining high quality standards. All materials used were premium grade and the client was extremely satisfied with the results.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.midGray,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.midGray,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'today';
    } else if (difference == 1) {
      return 'yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else {
      final months = (difference / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Portfolio Item'),
          content: const Text(
              'Are you sure you want to delete this portfolio item? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final controller = Get.find<PortfolioController>();
                controller.deletePortfolioItem(item.id);
                Navigator.of(context).pop();
                Get.back(); // Go back to portfolio page
                Get.snackbar(
                  'Success',
                  'Portfolio item deleted successfully',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
