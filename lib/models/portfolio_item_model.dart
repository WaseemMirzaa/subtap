part of 'models.dart';

class PortfolioItem {
  final String id;
  final String imageUrl;
  final String caption;
  final String category;
  final List<String> tags;
  final DateTime uploadDate;
  final bool isPdf;

  PortfolioItem({
    required this.id,
    required this.imageUrl,
    required this.caption,
    required this.category,
    required this.tags,
    required this.uploadDate,
    this.isPdf = false,
  });
}
