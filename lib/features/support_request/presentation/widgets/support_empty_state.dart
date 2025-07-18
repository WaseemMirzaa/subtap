import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class SupportEmptyState extends StatelessWidget {
  final VoidCallback onCreateRequest;

  const SupportEmptyState({
    super.key,
    required this.onCreateRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Assets.svgsUnfav,
                width: 80,
                height: 80,
                color: AppColor.lightGray,
              ),
              const SizedBox(height: 24),
              const Text(
                'No Support Requests Yet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'You don\'t have any support requests yet.\nNeed help? Start one now.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.midGray,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Create New Request',
                onTap: onCreateRequest,
                color: AppColor.mutedGold,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Navigate to FAQ/Help Center
                },
                child: const Text(
                  'Visit Help Center',
                  style: TextStyle(
                    color: AppColor.mutedGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
