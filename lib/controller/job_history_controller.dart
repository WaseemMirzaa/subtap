import 'package:get/get.dart';
import 'package:subtap/models/models.dart';

class JobHistoryController extends GetxController {
  // Store all jobs with their extras
  final RxList<JobHistory> _jobs = <JobHistory>[].obs;

  // Getter for jobs
  List<JobHistory> get jobs => _jobs;

  // Add or update a job in the list
  void updateJob(JobHistory job) {
    final index = _jobs.indexWhere((j) => j.title == job.title);
    if (index >= 0) {
      _jobs[index] = job;
    } else {
      _jobs.add(job);
    }
    print('Updated job: ${job.title}, Extras: ${job.extras.length}');
  }

  // Get a job by title
  JobHistory? getJob(String title) {
    return _jobs.firstWhereOrNull((job) => job.title == title);
  }

  // Add extras to a job
  void addExtras(String jobTitle, List<Map<String, dynamic>> extras) {
    final job = getJob(jobTitle);
    if (job != null) {
      updateJob(job.copyWith(
        extras: [...job.extras, ...extras],
        extrasStatus: 'pending',
      ));
      print('Added ${extras.length} extras to job: $jobTitle');
    } else {
      print('Job not found: $jobTitle');
    }
  }

  // Clear extras for a job
  void clearExtras(String jobTitle) {
    final job = getJob(jobTitle);
    if (job != null) {
      updateJob(job.copyWith(
        extras: [],
        extrasStatus: 'pending',
      ));
      print('Cleared extras for job: $jobTitle');
    }
  }
}
