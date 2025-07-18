import 'package:flutter/material.dart';
import 'package:subtap/core/theme/app_color.dart';

class JobStatusBadge extends StatelessWidget {
  final String? dueDate;
  final String? status;
  final String? urgencyTag; // Add urgencyTag parameter

  const JobStatusBadge({
    super.key,
    this.dueDate,
    this.status,
    this.urgencyTag, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    final badgeData = _getBadgeData();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeData['color'],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            badgeData['icon'],
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 4),
          Text(
            badgeData['text'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getBadgeData() {
    // For new jobs, ALWAYS prioritize urgencyTag if it exists
    if (status == 'new Jobs' && urgencyTag != null && urgencyTag!.isNotEmpty) {
      switch (urgencyTag!.toLowerCase()) {
        case 'new':
          return {'icon': '🆕', 'text': 'New', 'color': Colors.green};
        case 'urgent':
          return {'icon': '🔥', 'text': 'Urgent', 'color': Colors.red};
        case 'expiring soon':
          return {
            'icon': '⚠️',
            'text': 'Expiring Soon',
            'color': Colors.orange
          };
        case 'expired':
          return {'icon': '❌', 'text': 'Expired', 'color': Colors.red};
      }
    }

    // Only use date calculation if no urgencyTag is provided
    if (dueDate == null)
      return {'icon': '⏰', 'text': 'No due date', 'color': AppColor.midGray};

    final now = DateTime.now();
    final due = DateTime.tryParse(dueDate!) ?? _parseDueDate(dueDate!);
    final difference = due.difference(now).inDays;

    if (difference < 0) {
      return {
        'icon': '❌',
        'text': 'Expired ${(-difference)} days ago',
        'color': Colors.red
      };
    } else if (difference == 0) {
      return {'icon': '⚠️', 'text': 'ASAP', 'color': Colors.red};
    } else if (difference <= 2) {
      return {
        'icon': '⏰',
        'text': 'Due in $difference days',
        'color': Colors.red
      };
    } else if (difference <= 5) {
      return {
        'icon': '⏰',
        'text': 'Due in $difference days',
        'color': Colors.orange
      };
    } else {
      return {
        'icon': '⏰',
        'text': 'Due in $difference days',
        'color': Colors.green
      };
    }
  }

  DateTime _parseDueDate(String dateStr) {
    // Handle "Friday, May 23, 2025" format
    try {
      final parts = dateStr.split(', ');
      if (parts.length >= 2) {
        final monthDay = parts[1].split(' ');
        final year =
            parts.length > 2 ? int.parse(parts[2]) : DateTime.now().year;
        final month = _getMonthNumber(monthDay[0]);
        final day = int.parse(monthDay[1]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      // Fallback to current date + 7 days
      return DateTime.now().add(const Duration(days: 7));
    }
    return DateTime.now().add(const Duration(days: 7));
  }

  int _getMonthNumber(String month) {
    const months = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12
    };
    return months[month] ?? 1;
  }

  String? _getUrgencyFromContext() {
    // This is a workaround - we need to pass urgencyTag to JobStatusBadge
    // For now, return null and we'll fix this properly
    return null;
  }
}
