import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SupportRequestController extends GetxController {
  final RxList<SupportRequest> allRequests = <SupportRequest>[].obs;
  final RxList<SupportRequest> filteredRequests = <SupportRequest>[].obs;
  final RxString selectedTab = 'All'.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;

  final List<String> tabs = ['All', 'In Progress', 'Solved', 'Pending'];

  @override
  void onInit() {
    super.onInit();
    _initializeSampleData();
    ever(selectedTab, (_) => _filterRequests());
    ever(searchQuery, (_) => _filterRequests());
  }

  void _initializeSampleData() {
    allRequests.value = [
      SupportRequest(
        id: 'SR001',
        title: 'I need assistance with my cancelled order',
        orderId: 'FO52072C9E905',
        status: SupportStatus.inProgress,
        type: SupportType.general,
        submittedAt: DateTime.now().subtract(const Duration(hours: 2)),
        lastUpdatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
        lastUpdatedBy: 'Admin',
        responsePreview: 'We are reviewing your cancellation request...',
        isUnread: true,
        messages: [
          SupportMessage(
            id: 'msg1',
            text: 'I need to cancel my order due to scheduling conflicts',
            isFromUser: true,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ),
          SupportMessage(
            id: 'msg2',
            text: 'We are reviewing your cancellation request. We will get back to you shortly.',
            isFromUser: false,
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
            senderName: 'Admin',
          ),
        ],
      ),
      SupportRequest(
        id: 'SR002',
        title: 'Mediation Request Submitted',
        orderId: 'DIS-123456',
        status: SupportStatus.solved,
        type: SupportType.dispute,
        submittedAt: DateTime.now().subtract(const Duration(days: 1)),
        lastUpdatedAt: DateTime.now().subtract(const Duration(hours: 1)),
        lastUpdatedBy: 'Support Team',
        responsePreview: 'Refund issued. See more.',
        isUnread: false,
        disputeNumber: 'DIS-123456',
        messages: [
          SupportMessage(
            id: 'msg3',
            text: 'I need mediation for payment dispute',
            isFromUser: true,
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
          ),
          SupportMessage(
            id: 'msg4',
            text: 'Refund has been processed to your original payment method.',
            isFromUser: false,
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            senderName: 'Support Team',
          ),
        ],
      ),
    ];
    _filterRequests();
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void _filterRequests() {
    List<SupportRequest> filtered = List.from(allRequests);

    // Filter by tab
    if (selectedTab.value != 'All') {
      final status = _getStatusFromTab(selectedTab.value);
      filtered = filtered.where((req) => req.status == status).toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((req) {
        return req.title.toLowerCase().contains(query) ||
               req.orderId.toLowerCase().contains(query) ||
               req.responsePreview.toLowerCase().contains(query);
      }).toList();
    }

    // Sort by last updated (newest first)
    filtered.sort((a, b) => b.lastUpdatedAt.compareTo(a.lastUpdatedAt));

    filteredRequests.value = filtered;
  }

  SupportStatus _getStatusFromTab(String tab) {
    switch (tab) {
      case 'In Progress':
        return SupportStatus.inProgress;
      case 'Solved':
        return SupportStatus.solved;
      case 'Pending':
        return SupportStatus.pending;
      default:
        return SupportStatus.inProgress;
    }
  }

  void markAsRead(String requestId) {
    final index = allRequests.indexWhere((req) => req.id == requestId);
    if (index != -1) {
      allRequests[index] = allRequests[index].copyWith(isUnread: false);
      _filterRequests();
    }
  }

  void addNewRequest(SupportRequest request) {
    allRequests.insert(0, request);
    _filterRequests();
  }
}

class SupportRequest {
  final String id;
  final String title;
  final String orderId;
  final SupportStatus status;
  final SupportType type;
  final DateTime submittedAt;
  final DateTime lastUpdatedAt;
  final String lastUpdatedBy;
  final String responsePreview;
  final bool isUnread;
  final String? disputeNumber;
  final List<SupportMessage> messages;
  final List<String>? attachments;

  SupportRequest({
    required this.id,
    required this.title,
    required this.orderId,
    required this.status,
    required this.type,
    required this.submittedAt,
    required this.lastUpdatedAt,
    required this.lastUpdatedBy,
    required this.responsePreview,
    required this.isUnread,
    this.disputeNumber,
    required this.messages,
    this.attachments,
  });

  SupportRequest copyWith({
    String? id,
    String? title,
    String? orderId,
    SupportStatus? status,
    SupportType? type,
    DateTime? submittedAt,
    DateTime? lastUpdatedAt,
    String? lastUpdatedBy,
    String? responsePreview,
    bool? isUnread,
    String? disputeNumber,
    List<SupportMessage>? messages,
    List<String>? attachments,
  }) {
    return SupportRequest(
      id: id ?? this.id,
      title: title ?? this.title,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      type: type ?? this.type,
      submittedAt: submittedAt ?? this.submittedAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      responsePreview: responsePreview ?? this.responsePreview,
      isUnread: isUnread ?? this.isUnread,
      disputeNumber: disputeNumber ?? this.disputeNumber,
      messages: messages ?? this.messages,
      attachments: attachments ?? this.attachments,
    );
  }
}

class SupportMessage {
  final String id;
  final String text;
  final bool isFromUser;
  final DateTime timestamp;
  final String? senderName;
  final String? attachmentUrl;

  SupportMessage({
    required this.id,
    required this.text,
    required this.isFromUser,
    required this.timestamp,
    this.senderName,
    this.attachmentUrl,
  });
}

enum SupportStatus { pending, inProgress, solved }
enum SupportType { general, dispute, refund, technical }