import 'package:get/get.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/models/models.dart';

class SubcontractorNotificationController extends GetxController {
  // Reactive list of notifications
  final RxList<JobHistory> notificationJobs = <JobHistory>[
    JobHistory(
      title: 'New Job Opportunity',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Available Jobs',
      description:
          'You have a new job request for Carpentry & Farming Services from Jason Rao. Review the details and submit your proposal.',
      subcontractorModel: const SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Job request for carpentry and farming services.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesNotificationPerson,
        price: '50',
        rating: 4.0,
      ),
    ),
    JobHistory(
      title: 'Job Update',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      targetBudget: '\$65.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'Your Active Jobs',
      description:
          'The property manager has reviewed your progress update. Check for any feedback or additional instructions.',
      subcontractorModel: const SubcontractorModel(
        expertise: 'Electrician',
        description: 'Progress update reviewed for your ongoing project.',
        name: 'James Michael',
        imageUrl: Assets.imagesWood,
        price: '65',
        rating: 4.0,
      ),
    ),
    JobHistory(
      title: 'Proposal Accepted',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Active Jobs',
      description:
          'Your proposal for the Carpentry & Farming job has been accepted! The job is now active in your dashboard.',
      subcontractorModel: const SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Proposal accepted for carpentry job.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesSubcontractorMichael,
        price: '50',
        rating: 4.0,
      ),
    ),
    JobHistory(
      title: 'Extras Requested',
      svgIcon: Assets.svgsTrade,
      price: 120.0,
      targetBudget: '\$120.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'Completed Jobs',
      description:
          'A request for additional extras has been made for the Carpentry job. Review and accept or reject the request.',
      subcontractorModel: const SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Extras request for carpentry job.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesNotificationAvatar,
        price: '120',
        rating: 4.0,
      ),
    ),
    // Add new item for "Extras Request Accepted"
    JobHistory(
      title: 'Extras Request Accepted',
      svgIcon: Assets.svgsTrade,
      price: 225.0,
      targetBudget: '\$225.00',
      dueDate: 'Friday, May 16, 2025',
      address: '789 Pine St, Springfield',
      status: 'Completed Jobs',
      description:
          'Your request for additional extras for the Carpentry job has been accepted.',
      subcontractorModel: const SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Extras request accepted for carpentry job.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesNotificationAvatar,
        price: '225',
        rating: 4.0,
      ),
    ),
    // Add new item for "Extras Request Rejected"
    JobHistory(
      title: 'Extras Request Rejected',
      svgIcon: Assets.svgsTrade,
      price: 300.0,
      targetBudget: '\$300.00',
      dueDate: 'Friday, May 9, 2025',
      address: '101 Elm St, Springfield',
      status: 'Completed Jobs',
      description:
          'Your request for additional extras for the Carpentry job has been rejected.',
      subcontractorModel: const SubcontractorModel(
        expertise: 'Carpentry',
        description: 'Extras request rejected for carpentry job.',
        name: 'Jason Rao',
        imageUrl: Assets.imagesNotificationAvatar,
        price: '300',
        rating: 4.0,
      ),
    ),
  ].obs;

  // Reactive property for submitting state
  final RxBool isSubmitting = false.obs;

  // Method to remove a notification by index
  void removeNotification(int index) {
    if (index >= 0 && index < notificationJobs.length) {
      notificationJobs.removeAt(index);
    }
  }
}
