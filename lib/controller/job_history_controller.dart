class JobHistoryController {}

// import 'package:get/get.dart';
// import 'package:subtap/core/theme/assets.dart';
// import 'package:subtap/models/models.dart';

// class JobHistoryController extends GetxController {
//   var jobs = <JobHistory>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize with sample jobs (same as in JobHistoryPage)
//     jobs.assignAll([
//       const JobHistory(
//         title: 'General Trades',
//         svgIcon: Assets.svgsTrade,
//         price: 50.0,
//         targetBudget: '\$50.00',
//         dueDate: 'Friday, May 23, 2025',
//         address: '123 Main St, Springfield',
//         status: 'Requested Jobs',
//         description:
//             "I hope you're well.I'm looking to get some carpentry & \n Farming work done and wanted to see if you're avaiable.\n Please let me know.",
//         subcontractorModel: SubcontractorModel(
//           expertise: 'Electrician',
//           description:
//               'Leaking kitchen sink, Pipe may be cracked. Water dripping into cabinet below. Happened after turning on garbage disposal.',
//           name: 'James Michael',
//           imageUrl: Assets.imagesSubcontrctorImage,
//           price: '50',
//           rating: 4.0,
//         ),
//       ),
//       const JobHistory(
//         title: 'Electrical & Tech',
//         svgIcon: Assets.svgsTech,
//         price: 65.0,
//         targetBudget: '\$50.00',
//         dueDate: 'Friday, May 23, 2025',
//         address: '456 Oak Ave, Springfield',
//         status: 'Active Jobs',
//         description:
//             "I hope you're well.I'm looking to get some carpentry & \n Farming work done and wanted to see if you're avaiable.\n Please let me know.",
//         subcontractorModel: SubcontractorModel(
//           expertise: 'Electrician',
//           description:
//               'Leaking kitchen sink, Pipe may be cracked. Water dripping into cabinet below. Happened after turning on garbage disposal.',
//           name: 'James Michael',
//           imageUrl: 'path_to_image',
//           price: '50',
//           rating: 4.0,
//         ),
//       ),
//     ]);
//   }

//   void updateJobStatus(JobHistory job, String newStatus) {
//     final index = jobs.indexWhere((j) =>
//         j.title == job.title &&
//         j.address == job.address); // Identify job uniquely
//     if (index != -1) {
//       jobs[index] = JobHistory(
//         title: job.title,
//         svgIcon: job.svgIcon,
//         price: job.price,
//         targetBudget: job.targetBudget,
//         dueDate: job.dueDate,
//         address: job.address,
//         status: newStatus,
//         description: job.description,
//         subcontractorModel: job.subcontractorModel,
//       );
//       jobs.refresh(); // Notify UI of changes
//     }
//   }
// }
