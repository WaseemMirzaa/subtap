import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:subtap/controller/support_request_controller.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class EnhancedSupportRequestCard extends StatelessWidget {
  final SupportRequest request;
  final VoidCallback onTap;

  const EnhancedSupportRequestCard({
    super.key,
    required this.request,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (request.isUnread) {
          Get.find<SupportRequestController>().markAsRead(request.id);
        }
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: request.isUnread 
              ? Border.all(color: AppColor.mutedGold, width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildTitle(),
            const SizedBox(height: 8),
            _buildOrderInfo(),
            const SizedBox(height: 12),
            _buildTimestamps(),
            const SizedBox(height: 8),
            _buildResponsePreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        _buildStatusChip(),
        const Spacer(),
        if (request.isUnread) ...[
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColor.mutedGold,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
        ],
        _buildTypeIcon(),
      ],
    );
  }

  Widget _buildStatusChip() {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (request.status) {
      case SupportStatus.inProgress:
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        icon = Icons.access_time;
        break;
      case SupportStatus.solved:
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        icon = Icons.check_circle;
        break;
      case SupportStatus.pending:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
        icon = Icons.pending;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            _getStatusText(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeIcon() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: request.type == SupportType.dispute 
            ? Colors.orange.shade50 
            : AppColor.lightGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        request.type == SupportType.dispute 
            ? Icons.gavel 
            : Icons.support_agent,
        size: 16,
        color: request.type == SupportType.dispute 
            ? Colors.orange.shade600 
            : AppColor.midGray,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      request.title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: request.isUnread ? FontWeight.bold : FontWeight.w600,
        color: AppColor.black,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildOrderInfo() {
    return Row(
      children: [
        Icon(Icons.receipt_long, size: 14, color: AppColor.midGray),
        const SizedBox(width: 4),
        Text(
          request.type == SupportType.dispute 
              ? 'Dispute #${request.disputeNumber}'
              : 'Order #${request.orderId}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.midGray,
          ),
        ),
      ],
    );
  }

  Widget _buildTimestamps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.schedule, size: 12, color: AppColor.midGray),
            const SizedBox(width: 4),
            Text(
              'Submitted: ${_formatTimestamp(request.submittedAt)}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColor.midGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Icon(Icons.update, size: 12, color: AppColor.midGray),
            const SizedBox(width: 4),
            Text(
              'Last updated: ${_formatTimestamp(request.lastUpdatedAt)} by ${request.lastUpdatedBy}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColor.midGray,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResponsePreview() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.whiteSmoke,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              request.responsePreview,
              style: const TextStyle(
                fontSize: 13,
                color: AppColor.midGray,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward_ios,
            size: 12,
            color: AppColor.midGray,
          ),
        ],
      ),
    );
  }

  String _getStatusText() {
    switch (request.status) {
      case SupportStatus.inProgress:
        return 'In Progress';
      case SupportStatus.solved:
        return 'Solved';
      case SupportStatus.pending:
        return 'Pending';
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return DateFormat('MMM d, h:mm a').format(timestamp);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
}