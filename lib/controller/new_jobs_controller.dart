import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/models/models.dart';

class NewJobsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxBool isSearching = false.obs;
  final RxList<JobHistory> filteredJobs = <JobHistory>[].obs;
  final RxList<JobHistory> removedJobs =
      <JobHistory>[].obs; // Track removed jobs

  final RxList<JobHistory> allJobs = <JobHistory>[
    // Card 1 - Fixed Payment
    JobHistory(
      title: 'Hang Drywall at Retail Store',
      svgIcon: Assets.svgsTrade,
      price: 50.0,
      manager: 'John Doe',
      targetBudget: '\$50',
      dueDate: '2024-12-25',
      address: 'Springfield, IL 62704',
      fullAddress: '123 Main St, Springfield, IL 62704',
      status: 'new Jobs',
      trade: 'Carpentry & Framing',
      paymentType: 'Fixed',
      estimatedHours: '4 hrs est.',
      urgencyTag: 'New',
      description:
          "Looking to get drywall hanging work done at retail location.",
      propertyManager: const PropertyManagerModel(
        name: 'John Doe',
        imageUrl: Assets.imagesSubcontractorBrown,
        rating: 4.7,
        totalJobs: 18,
        isVerified: true,
      ),
    ),
    // Card 2 - Hourly Payment
    JobHistory(
      title: 'Paint Office Interior – 2 Rooms',
      svgIcon: Assets.svgsTech,
      price: 25.0,
      manager: 'Jane Smith',
      targetBudget: '\$25/hr',
      dueDate: '2024-12-30',
      address: 'Chicago, IL 60601',
      fullAddress: '456 Oak Ave, Chicago, IL 60601',
      status: 'new Jobs',
      trade: 'Painting & Finishing',
      paymentType: 'Hourly',
      estimatedHours: '8 hrs est.',
      urgencyTag: 'Urgent',
      description:
          "Need professional painting for office interior, 2 rooms total.",
      propertyManager: const PropertyManagerModel(
        name: 'Jane Smith',
        imageUrl: Assets.imagesHomePerson,
        rating: 4.6,
        totalJobs: 12,
        isVerified: true,
      ),
    ),
    // Card 3 - Negotiable Payment
    JobHistory(
      title: 'Kitchen Cabinet Installation',
      svgIcon: Assets.svgsGeneral,
      price: 0.0,
      manager: 'Mike Johnson',
      targetBudget: 'Negotiable',
      dueDate: '2024-12-28',
      address: 'Austin, TX 73301',
      fullAddress: '789 Pine St, Austin, TX 73301',
      status: 'new Jobs',
      trade: 'Carpentry & Installation',
      paymentType: 'Negotiable',
      estimatedHours: '12 hrs est.',
      urgencyTag: 'Expiring Soon',
      description: "Install custom kitchen cabinets in residential property.",
      propertyManager: const PropertyManagerModel(
        name: 'Mike Johnson',
        imageUrl: Assets.imagesSubcontractorBrown,
        rating: 4.8,
        totalJobs: 25,
        isVerified: true,
      ),
    ),
    // Card 4 - Per Square Foot Payment (EXPIRED)
    JobHistory(
      title: 'Tile Bathroom Floor',
      svgIcon: Assets.svgsPlumbing,
      price: 8.0,
      manager: 'Sarah Wilson',
      targetBudget: '\$8/sq ft',
      dueDate: '2024-01-15', // Past date - properly expired
      address: 'Miami, FL 33101',
      fullAddress: '321 Ocean Dr, Miami, FL 33101',
      status: 'new Jobs',
      trade: 'Flooring & Tiling',
      paymentType: 'Per Sq Ft',
      estimatedHours: '6 hrs est.',
      urgencyTag: 'Expired',
      description:
          "Tile installation for bathroom floor, approximately 50 sq ft.",
      propertyManager: const PropertyManagerModel(
        name: 'Sarah Wilson',
        imageUrl: Assets.imagesHomePerson,
        rating: 4.9,
        totalJobs: 31,
        isVerified: true,
      ),
    ),
  ].obs;

  void removeJob(int index) {
    if (index >= 0 && index < filteredJobs.length) {
      final removedJob = filteredJobs[index];
      removedJobs.add(removedJob);
      filteredJobs.removeAt(index);
      allJobs.remove(removedJob);
    }
  }

  void undoRemoveJob(JobHistory job, int originalIndex) {
    removedJobs.remove(job);
    allJobs.insert(originalIndex, job);
    filteredJobs.insert(originalIndex, job);
  }

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
