import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/models/models.dart';

class NewJobsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxBool isSearching = false.obs;

  final RxList<JobHistory> allJobs = <JobHistory>[
    JobHistory(
      title: 'General Trades',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      manager: 'John Doe',
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '123 Main St, Springfield',
      status: 'new Jobs',
      description: "Looking to get some carpentry & farming work done.",
      propertyManager: const PropertyManagerModel(
        name: 'John Doe',
        imageUrl: Assets.imagesSubcontractorBrown,
        rating: 4.6,
        totalJobs: 12,
        isVerified: true,
      ),
      subcontractorModel: const SubcontractorModel(
        expertise: 'Electrician',
        description: 'Leaking kitchen sink...',
        name: 'James Michael',
        imageUrl: Assets.imagesSubcontrctorImage,
        price: '50',
        rating: 4.0,
      ),
    ),
    JobHistory(
      title: 'General Trades',
      svgIcon: Assets.svgsTech,
      price: 65.0,
      manager: 'Jane ',
      targetBudget: '\$50.00',
      dueDate: 'Friday, May 23, 2025',
      address: '456 Oak Ave, Springfield',
      status: 'new Jobs',
      description:
          "I hope you're well.I'm looking to get some carpentry & \n Farming work done and wanted to see if you're avaiable.\n Please let me know.",
      propertyManager: const PropertyManagerModel(
        name: 'Jane ',
        imageUrl: Assets.imagesHomePerson,
        rating: 4.6,
        totalJobs: 12,
        isVerified: true,
      ),
      subcontractorModel: const SubcontractorModel(
        expertise: 'Electrician',
        description:
            'Leaking kitchen sink, Pipe may be cracked. Water \n dripping into cabinet below. Happened after  turning on  garbage disposal.',
        name: 'James Michael',
        imageUrl: 'path_to_image',
        price: '50',
        rating: 4.0,
      ),
    ),
    // ... more jobs
  ].obs;

  final RxList<JobHistory> filteredJobs = <JobHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredJobs.assignAll(allJobs);

    // Add listener to searchController to perform search as user types
    searchController.addListener(() {
      performSearch(searchController.text);
    });
  }

  @override
  void onClose() {
    // Clean up the controller when it's no longer needed
    searchController.removeListener(() {
      performSearch(searchController.text);
    });
    searchController.dispose();
    super.onClose();
  }

  // void performSearch(String query) {
  //   if (query.isEmpty) {
  //     isSearching.value = false;
  //     filteredJobs.assignAll(allJobs);
  //     return;
  //   }

  //   isSearching.value = true;

  //   // Add small delay to simulate search and show loading
  //   Future.delayed(const Duration(milliseconds: 300), () {
  //     final lowerQuery = query.toLowerCase();
  //     filteredJobs.value = allJobs.where((job) {
  //       return job.title.toLowerCase().contains(lowerQuery) ||
  //           job.manager?.toLowerCase().contains(lowerQuery) == true ||
  //           job.subcontractorModel.name.toLowerCase().contains(lowerQuery) ||
  //           job.subcontractorModel.expertise.toLowerCase().contains(lowerQuery);
  //     }).toList();

  //     isSearching.value = false;
  //   });
  // }
  void performSearch(String query) {
    if (query.isEmpty) {
      isSearching.value = false;
      filteredJobs.assignAll(allJobs);
      return;
    }

    isSearching.value = true;

    // Add small delay to simulate search and show loading
    Future.delayed(const Duration(milliseconds: 300), () {
      final lowerQuery = query.toLowerCase();
      filteredJobs.value = allJobs.where((job) {
        return (job.title?.toLowerCase() ?? '').contains(lowerQuery) ||
            (job.manager?.toLowerCase() ?? '').contains(lowerQuery) ||
            (job.subcontractorModel?.name?.toLowerCase() ?? '')
                .contains(lowerQuery) ||
            (job.subcontractorModel?.expertise?.toLowerCase() ?? '')
                .contains(lowerQuery);
      }).toList();

      isSearching.value = false;
    });
  }
}
