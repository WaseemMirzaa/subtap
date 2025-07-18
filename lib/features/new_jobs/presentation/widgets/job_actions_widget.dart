import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:subtap/core/theme/app_color.dart';

import '../../../../controller/new_jobs_controller.dart';

class JobActionsWidget extends StatelessWidget {
  final String jobTitle;
  final String jobId;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  const JobActionsWidget({
    super.key,
    required this.jobTitle,
    required this.jobId,
    required this.isBookmarked,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          label: 'Save',
          onTap: onBookmarkTap,
          color: isBookmarked ? AppColor.mutedGold : AppColor.midGray,
        ),
        _buildActionButton(
          icon: Icons.share,
          label: 'Share',
          onTap: () => _shareJob(),
          color: AppColor.midGray,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _shareJob() {
    Share.share(
      'Check out this job: $jobTitle\nJob ID: $jobId\n\nShared via SubTap',
      subject: 'Job Opportunity: $jobTitle',
    );
  }
}
