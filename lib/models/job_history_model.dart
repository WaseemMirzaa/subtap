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
    );
  }
}
