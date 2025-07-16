part of 'models.dart';

class PropertyManagerModel {
  final String name;
  final String imageUrl;
  final double rating;
  final int totalJobs;
  final bool isVerified;

  const PropertyManagerModel({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.totalJobs,
    this.isVerified = false,
  });
}