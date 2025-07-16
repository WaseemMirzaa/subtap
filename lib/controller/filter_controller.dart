import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/new_jobs_controller.dart';
import 'package:subtap/models/models.dart';

class FilterController extends GetxController {
  // Text controllers
  final zipCodeController = TextEditingController();
  final searchController = TextEditingController();

  // Observable variables
  final radius = 5.0.obs;
  final selectedCategory = Rxn<String>();
  final minRating = 5.0.obs;
  final minBudget = 0.0.obs;
  final maxBudget = 1000.0.obs;
  final selectedDueDate = Rxn<String>();
  final selectedJobType = Rxn<String>();
  final showInvitedOnly = false.obs;

  // Categories
  final List<String> allCategories = [
    'Electrician',
    'Plumber',
    'Mechanic',
    'Carpenter',
    'Painter',
    'Cleaner',
    'Gardener',
    'Chef',
    'Tutor',
    'Photographer',
    'Barber',
    'Tailor',
    'Driver',
    'Delivery',
    'Repair Service',
  ];

  final filteredCategories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredCategories.assignAll(allCategories);
    searchController.addListener(_filterCategories);
  }

  @override
  void onClose() {
    zipCodeController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void _filterCategories() {
    if (searchController.text.isEmpty) {
      filteredCategories.assignAll(allCategories);
    } else {
      filteredCategories.assignAll(allCategories
          .where((category) => category
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList());
    }
  }

  void updateRadius(double value) {
    radius.value = value;
  }

  void updateBudgetRange(double min, double max) {
    minBudget.value = min;
    maxBudget.value = max;
  }

  void updateDueDate(String? value) {
    selectedDueDate.value = value;
  }

  void updateJobType(String? value) {
    selectedJobType.value = value;
  }

  void updateInvitedOnly(bool value) {
    showInvitedOnly.value = value;
  }

  void updateCategory(String? value) {
    selectedCategory.value = value;
  }

  void updateRating(double value) {
    minRating.value = value;
  }

  void resetFilters() {
    zipCodeController.clear();
    radius.value = 5.0;
    minBudget.value = 0.0;
    maxBudget.value = 1000.0;
    selectedDueDate.value = null;
    selectedJobType.value = null;
    showInvitedOnly.value = false;
    minRating.value = 5.0;
    selectedCategory.value = null;
    searchController.clear();

    // Reset filtered jobs to show all jobs
    final newJobsController = Get.find<NewJobsController>();
    newJobsController.filteredJobs.assignAll(newJobsController.allJobs);
  }

  void applyFilters() {
    final newJobsController = Get.find<NewJobsController>();

    // Apply filters to the jobs list
    List<JobHistory> filteredJobs = newJobsController.allJobs.where((job) {
      // Location filter (if zip code is provided)
      // You can implement location-based filtering here

      // Category filter
      if (selectedCategory.value != null) {
        if (job.subcontractorModel?.expertise == null ||
            !job.subcontractorModel!.expertise
                .toLowerCase()
                .contains(selectedCategory.value!.toLowerCase())) {
          return false;
        }
      }

      // Budget filter
      if (job.price == null ||
          job.price! < minBudget.value ||
          job.price! > maxBudget.value) {
        return false;
      }

      // Rating filter
      if (job.subcontractorModel?.rating == null ||
          job.subcontractorModel!.rating < minRating.value) {
        return false;
      }

      // Job type filter
      if (selectedJobType.value != null) {
        // You can add job type property to JobHistory model if needed
        // For now, this is a placeholder
      }

      // Due date filter
      if (selectedDueDate.value != null) {
        // You can implement due date filtering based on job.dueDate
        // For now, this is a placeholder
      }

      // Invited jobs filter
      if (showInvitedOnly.value) {
        // You can add invited property to JobHistory model if needed
        // For now, this is a placeholder
      }

      return true;
    }).toList();

    // Update the filtered jobs in NewJobsController
    newJobsController.filteredJobs.assignAll(filteredJobs);

    // Close the filter dialog
    Get.back();
  }

  // Add computed property for active filter count
  int get activeFilterCount {
    int count = 0;

    if (zipCodeController.text.isNotEmpty) count++;
    if (radius.value != 5.0) count++;
    if (selectedCategory.value != null) count++;
    if (minRating.value != 5.0) count++;
    if (minBudget.value != 0.0 || maxBudget.value != 1000.0) count++;
    if (selectedDueDate.value != null) count++;
    if (selectedJobType.value != null) count++;
    if (showInvitedOnly.value == true) count++;

    return count;
  }
}
