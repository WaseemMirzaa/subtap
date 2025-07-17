part of 'models.dart';

class Job {
  final String id;
  final String title;
  final String description;
  final String skill;
  final String status;
  final String location;
  final double lat;
  final double lng;
  final String propertyManagerId;
  final double budget;
  final DateTime deadline;
  final bool isInvited;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.skill,
    required this.status,
    required this.location,
    required this.lat,
    required this.lng,
    required this.propertyManagerId,
    required this.budget,
    required this.deadline,
    this.isInvited = false,
  });
}
