import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/theme/app_color.dart';

class UploadPortfolioBottomSheet extends StatelessWidget {
  const UploadPortfolioBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColor.lightGray,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Upload Portfolio',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildUploadOption(
            icon: Icons.photo_library,
            title: 'Select Photos',
            subtitle: 'Choose multiple photos from gallery',
            onTap: () {
              // Handle photo selection
              Get.back();
            },
          ),
          const SizedBox(height: 12),
          _buildUploadOption(
            icon: Icons.camera_alt,
            title: 'Take Photo',
            subtitle: 'Capture new photos',
            onTap: () {
              // Handle camera
              Get.back();
            },
          ),
          const SizedBox(height: 12),
          _buildUploadOption(
            icon: Icons.picture_as_pdf,
            title: 'Upload PDF',
            subtitle: 'Licenses, certificates, documents',
            onTap: () {
              // Handle PDF upload
              Get.back();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.offWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.mutedGold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColor.mutedGold),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.midGray,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: AppColor.midGray),
          ],
        ),
      ),
    );
  }
}
