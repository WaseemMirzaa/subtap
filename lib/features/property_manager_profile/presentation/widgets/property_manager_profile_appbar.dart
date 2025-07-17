import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/models/models.dart';

class PropertyManagerProfileAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  final PropertyManagerModel propertyManager;
  final Function(bool) onViewChanged;

  const PropertyManagerProfileAppbar({
    super.key,
    required this.propertyManager,
    required this.onViewChanged,
  });

  @override
  State<PropertyManagerProfileAppbar> createState() =>
      _PropertyManagerProfileAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(240);
}

class _PropertyManagerProfileAppbarState
    extends State<PropertyManagerProfileAppbar> {
  bool _isProfileIconTapped = true;
  bool _isJobsIconTapped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top bar with back and icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  InkWell(
                    onTap: () => Get.back(),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColor.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  // Toggle Icons
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.person,
                          size: 22,
                          color: _isProfileIconTapped
                              ? AppColor.mutedGold
                              : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isProfileIconTapped = true;
                            _isJobsIconTapped = false;
                          });
                          widget.onViewChanged(false);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.work,
                          size: 22,
                          color: _isJobsIconTapped
                              ? AppColor.mutedGold
                              : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isProfileIconTapped = false;
                            _isJobsIconTapped = true;
                          });
                          widget.onViewChanged(true);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Profile Picture
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(widget.propertyManager.imageUrl),
              ),
              const SizedBox(height: 10),
              // Name + Verified Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.propertyManager.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (widget.propertyManager.isVerified) ...[
                    const SizedBox(width: 6),
                    SvgPicture.asset(
                      Assets.svgsVerify,
                      width: 20,
                      height: 20,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              // Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.svgsStar,
                    width: 16,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.propertyManager.rating} ★ (${widget.propertyManager.totalJobs} jobs)',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
