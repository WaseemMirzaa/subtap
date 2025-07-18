part of 'models.dart';

class JobHistory {
  final String? title;
  final String? svgIcon;
  final double? price;
  final String? targetBudget;
  final String? dueDate;
  final String? address;
  final String? status;
  final String? description;
  final SubcontractorModel? subcontractorModel;
  final bool showQuoteButtons;
  List<Map<String, dynamic>> extras;
  String? extrasStatus;
  final String? manager;
  final PropertyManagerModel? propertyManager;
  final String? feedback;
  final double? feedbackRating;
  bool isRead;
  bool isArchived;

  // New optional fields
  final String? fullAddress;
  final String? trade;
  final String? paymentType;
  final String? estimatedHours;
  final String? urgencyTag;

  JobHistory({
    this.title,
    this.svgIcon,
    this.price,
    this.targetBudget,
    this.dueDate,
    this.address,
    this.status,
    this.description,
    this.subcontractorModel,
    this.showQuoteButtons = false,
    this.extras = const [],
    this.extrasStatus = 'pending',
    this.manager,
    this.propertyManager,
    this.feedback,
    this.feedbackRating,
    this.isRead = false,
    this.isArchived = false,
    // New optional parameters
    this.fullAddress,
    this.trade,
    this.paymentType,
    this.estimatedHours,
    this.urgencyTag,
  });

  bool get hasExtras => extras.isNotEmpty;

  JobHistory copyWith({
    String? title,
    String? svgIcon,
    double? price,
    String? targetBudget,
    String? dueDate,
    String? address,
    String? status,
    String? description,
    SubcontractorModel? subcontractorModel,
    bool? showQuoteButtons,
    List<Map<String, dynamic>>? extras,
    String? extrasStatus,
    String? manager,
    PropertyManagerModel? propertyManager,
    String? feedback,
    double? feedbackRating,
    bool? isRead,
    bool? isArchived,
    // New optional parameters in copyWith
    String? fullAddress,
    String? trade,
    String? paymentType,
    String? estimatedHours,
    String? urgencyTag,
  }) {
    return JobHistory(
      title: title ?? this.title,
      svgIcon: svgIcon ?? this.svgIcon,
      price: price ?? this.price,
      targetBudget: targetBudget ?? this.targetBudget,
      dueDate: dueDate ?? this.dueDate,
      address: address ?? this.address,
      status: status ?? this.status,
      description: description ?? this.description,
      subcontractorModel: subcontractorModel ?? this.subcontractorModel,
      showQuoteButtons: showQuoteButtons ?? this.showQuoteButtons,
      extras: extras ?? this.extras,
      extrasStatus: extrasStatus ?? this.extrasStatus,
      manager: manager ?? this.manager,
      propertyManager: propertyManager ?? this.propertyManager,
      feedback: feedback ?? this.feedback,
      feedbackRating: feedbackRating ?? this.feedbackRating,
      isRead: isRead ?? this.isRead,
      isArchived: isArchived ?? this.isArchived,
      // New fields in copyWith
      fullAddress: fullAddress ?? this.fullAddress,
      trade: trade ?? this.trade,
      paymentType: paymentType ?? this.paymentType,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      urgencyTag: urgencyTag ?? this.urgencyTag,
    );
  }
}
