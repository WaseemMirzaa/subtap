import 'package:get/get.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/models/models.dart';

class NotificationController extends GetxController {
  // Reactive list of notifications
  final RxList<JobHistory> notificationJobs = <JobHistory>[
    const JobHistory(
      title: 'New Proposal Received',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Requested Jobs',
      description:
          'Jason Rao sent you a new proposal for Carpentry & Farming Services. Please review the details at your earliest convenience.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Proposal for carpentry and farming services.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesNotificationPerson,
        price: '50',
        rating: 4.0,
      ),
    ),
    const JobHistory(
      title: 'Progress Update Submitted',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      targetBudget: '\$65.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'Active Jobs',
      description:
          'A subcontractor has uploaded new progress updates, including notes and/or photos. Please log in to review the latest submission.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Electrician',
        description: 'Progress update for ongoing project.',
        name: 'James Michael',
        imageUrl: Assets.imagesWood,
        price: '65',
        rating: 4.0,
      ),
    ),
  ].obs;

  // Method to remove a notification by index
  void removeNotification(int index) {
    if (index >= 0 && index < notificationJobs.length) {
      notificationJobs.removeAt(index);
    }
  }
}
