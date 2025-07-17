import 'package:get/get.dart';

class SubcontrctorJobHistoryController extends GetxController {
  final RxString selectedTab = 'Open Jobs'.obs;

  // Tab options
  final List<String> tabs = ['Open Jobs', 'Active Jobs', 'Job History'];

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  @override
  void onReady() {
    super.onReady();
    print('Controller ready');
  }
}
