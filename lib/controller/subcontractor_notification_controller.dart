import 'package:get/get.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/models/models.dart';

class SubcontractorNotificationController extends GetxController {
  // Reactive list of notifications
  final RxList<JobHistory> notificationJobs = <JobHistory>[
    const JobHistory(
      title: 'New Job Opportunity',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Available Jobs',
      description:
          'You have a new job request for Carpentry & Farming Services from Jason Rao. Review the details and submit your proposal.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Job request for carpentry and farming services.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesNotificationPerson,
        price: '50',
        rating: 4.0,
      ),
    ),
    const JobHistory(
      title: 'Job Update',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      targetBudget: '\$65.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'Your Active Jobs',
      description:
          'The property manager has reviewed your progress update. Check for any feedback or additional instructions.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Electrician',
        description: 'Progress update reviewed for your ongoing project.',
        name: 'James Michael',
        imageUrl: Assets.imagesWood,
        price: '65',
        rating: 4.0,
      ),
    ),
    const JobHistory(
      title: 'Proposal Accepted',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Active Jobs',
      description:
          'Your proposal for the Carpentry & Farming job has been accepted! The job is now active in your dashboard.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Proposal accepted for carpentry job.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesSubcontractorMichael,
        price: '50',
        rating: 4.0,
      ),
    ),
    const JobHistory(
      title: 'Payment Received',
      svgIcon: Assets.svgsTrade,
      price: 120.0,
      targetBudget: '\$120.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Completed Jobs',
      description:
          'You\'ve received a payment of \$120.00 for the completed Carpentry job. Funds will be available in your account within 2-3 business days.',
      subcontractorModel: SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Payment for completed carpentry job.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesNotificationAvatar,
        price: '120',
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
