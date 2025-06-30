import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  // Observable variables for start and end dates
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;

  // Function to update start date
  void updateStartDate(DateTime date) {
    startDate.value = date;
  }

  // Function to update end date
  void updateEndDate(DateTime date) {
    endDate.value = date;
  }

  // Optional: Formatted date strings for display
  String get formattedStartDate =>
      DateFormat('yyyy-MM-dd').format(startDate.value);
  String get formattedEndDate => DateFormat('yyyy-MM-dd').format(endDate.value);
}
