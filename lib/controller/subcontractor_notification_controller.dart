import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:subtap/models/models.dart';

import 'package:intl/intl.dart';

class SubcontractorNotificationController extends GetxController {
  // Filter tabs
  final RxString selectedTab = 'Unread'.obs;
  final List<String> tabs = ['All', 'Unread', 'Read', 'Archived'];

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

  // Filtered notifications based on selected tab
  List<JobHistory> get filteredNotifications {
    switch (selectedTab.value) {
      case 'Unread':
        return notificationJobs.where((job) => !job.isRead).toList();
      case 'Read':
        return notificationJobs
            .where((job) => job.isRead && !job.isArchived)
            .toList();
      case 'Archived':
        return notificationJobs.where((job) => job.isArchived).toList();
      case 'All':
      default:
        return notificationJobs.where((job) => !job.isArchived).toList();
    }
  }

  // Reactive property for submitting state
  final RxBool isSubmitting = false.obs;

  // Method to change selected tab
  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  // Method to remove a notification by index
  void removeNotification(int index) {
    if (index >= 0 && index < notificationJobs.length) {
      notificationJobs.removeAt(index);
    }
  }

  // Method to mark notification as read
  void markAsRead(int index) {
    if (index >= 0 && index < notificationJobs.length) {
      final job = notificationJobs[index];
      job.isRead = true;
      notificationJobs.refresh();
    }
  }

  // Method to archive notification
  void archiveNotification(int index) {
    if (index >= 0 && index < notificationJobs.length) {
      final job = notificationJobs[index];
      job.isArchived = true;
      notificationJobs.refresh();
    }
  }

  // Method to clear all read notifications
  void clearAllRead() {
    notificationJobs.removeWhere((job) => job.isRead && !job.isArchived);
  }

  // Get notification color based on type
  Color getNotificationColor(String title) {
    if (title.contains('Job Opportunity') || title.contains('Proposal')) {
      return Colors.blue; // Blue for invites
    } else if (title.contains('Extras')) {
      return Colors.orange; // Orange for extras
    } else if (title.contains('Accepted')) {
      return Colors.green; // Green for accepted
    } else if (title.contains('Rejected')) {
      return Colors.red; // Red for rejected
    } else {
      return Colors.grey; // Default color
    }
  }

  // Format notification time
  String formatNotificationTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final notificationDate = DateTime(time.year, time.month, time.day);

    if (notificationDate == today) {
      return 'Today at ${time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}';
    } else if (notificationDate == yesterday) {
      return 'Yesterday';
    } else if (now.difference(time).inDays < 7) {
      return DateFormat('EEEE').format(time); // Day name
    } else {
      return DateFormat('MMM d, yyyy').format(time);
    }
  }
}
