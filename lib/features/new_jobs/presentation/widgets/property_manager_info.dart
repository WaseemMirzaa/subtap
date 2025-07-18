import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/models/models.dart';

class PropertyManagerInfo extends StatelessWidget {
  final PropertyManagerModel? propertyManager;
  final VoidCallback? onMessageTap;

  const PropertyManagerInfo({
    super.key,
    this.propertyManager,
    this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    if (propertyManager == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.lightGray),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, size: 16, color: AppColor.midGray),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Posted by ${propertyManager!.name}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (propertyManager!.isVerified)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColor.mutedGold,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Verified PM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(Assets.svgsStar, width: 12, height: 12),
                    const SizedBox(width: 4),
                    Text(
                      '${propertyManager!.rating} · ${propertyManager!.totalJobs} reviews',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.midGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onMessageTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.mutedGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.message,
                size: 16,
                color: AppColor.mutedGold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
