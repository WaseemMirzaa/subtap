import 'package:get/get.dart';

class NewJobDetailController extends GetxController {
  final RxBool isBookmarked = false.obs;
  final RxBool isJobExpired = false.obs;

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
  }

  void checkJobExpiry(String? dueDate, String? urgencyTag) {
    // First check urgencyTag
    if (urgencyTag != null && urgencyTag.toLowerCase() == 'expired') {
      isJobExpired.value = true;
      return;
    }

    // Then check date
    if (dueDate == null) return;

    try {
      final now = DateTime.now();
      final due = _parseDueDate(dueDate);
      isJobExpired.value = due.isBefore(now);
      print(
          'Due date: $dueDate, Parsed: $due, Now: $now, Expired: ${isJobExpired.value}');
    } catch (e) {
      print('Error parsing date: $e');
      isJobExpired.value = false;
    }
  }

  DateTime _parseDueDate(String dateStr) {
    // Handle "Friday, May 10, 2024" format
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
      print('Date parsing error: $e');
      // Fallback to current date + 7 days
      return DateTime.now().add(const Duration(days: 7));
    }
    return DateTime.now().add(const Duration(days: 7));
  }

  int _getMonthNumber(String monthName) {
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
    return months[monthName] ?? 1;
  }

  String formatDescription(String? description) {
    if (description == null || description.isEmpty) {
      return 'No description available';
    }

    // Basic cleanup
    String cleaned = description
        .replaceAll(RegExp(r'\s+'), ' ') // Multiple spaces to single
        .replaceAll(RegExp(r'\.+'), '.') // Multiple dots to single
        .trim();

    // Ensure proper sentence ending
    if (!cleaned.endsWith('.') &&
        !cleaned.endsWith('!') &&
        !cleaned.endsWith('?')) {
      cleaned += '.';
    }

    return cleaned;
  }
}
