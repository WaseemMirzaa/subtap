import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:subtap/core/theme/assets.dart';

class ChatController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxList<ChatThread> chatThreads = <ChatThread>[].obs;
  final RxList<ChatThread> filteredChats = <ChatThread>[].obs;
  final RxMap<String, bool> typingStatus = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeChatData();
    ever(searchQuery, _filterChats);
  }

  void _initializeChatData() {
    chatThreads.value = [
      ChatThread(
        id: '1',
        participantName: 'Michael Thompson',
        participantAvatar: Assets.imagesChatMichael,
        jobTitle: 'Carpentry – Job #123',
        jobIcon: '🛠️',
        lastMessage: 'Can we discuss the urgent invoice for the delayed project?',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 2,
        isOnline: true,
        isPinned: true,
        hasAttachment: false,
        isRead: false,
        messageType: MessageType.text,
      ),
      ChatThread(
        id: '2',
        participantName: 'Sarah Johnson',
        participantAvatar: Assets.imagesChatSarah,
        jobTitle: 'Landscaping – Job #456',
        jobIcon: '🌾',
        lastMessage: 'Let\'s talk on Wednesday about the project timeline',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 0,
        isOnline: true,
        isPinned: false,
        hasAttachment: true,
        isRead: true,
        messageType: MessageType.image,
      ),
      ChatThread(
        id: '3',
        participantName: 'David Wilson',
        participantAvatar: Assets.imagesChatDavid,
        jobTitle: 'Plumbing – Job #789',
        jobIcon: '🔧',
        lastMessage: 'Invoice attached for your review',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
        unreadCount: 1,
        isOnline: false,
        isPinned: false,
        hasAttachment: true,
        isRead: false,
        messageType: MessageType.document,
      ),
    ];
    _sortChats();
  }

  void _filterChats(String query) {
    if (query.isEmpty) {
      filteredChats.value = List.from(chatThreads);
    } else {
      filteredChats.value = chatThreads.where((chat) {
        return chat.participantName.toLowerCase().contains(query.toLowerCase()) ||
               chat.lastMessage.toLowerCase().contains(query.toLowerCase()) ||
               chat.jobTitle.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    _sortChats();
  }

  void _sortChats() {
    filteredChats.sort((a, b) {
      // Pinned chats first
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      
      // Unread chats next
      if (!a.isRead && b.isRead) return -1;
      if (a.isRead && !b.isRead) return 1;
      
      // Then by time
      return b.lastMessageTime.compareTo(a.lastMessageTime);
    });
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void togglePin(String chatId) {
    final index = chatThreads.indexWhere((chat) => chat.id == chatId);
    if (index != -1) {
      chatThreads[index] = chatThreads[index].copyWith(
        isPinned: !chatThreads[index].isPinned,
      );
      _filterChats(searchQuery.value);
    }
  }

  void markAsRead(String chatId) {
    final index = chatThreads.indexWhere((chat) => chat.id == chatId);
    if (index != -1) {
      chatThreads[index] = chatThreads[index].copyWith(
        isRead: true,
        unreadCount: 0,
      );
      _filterChats(searchQuery.value);
    }
  }

  void archiveChat(String chatId) {
    chatThreads.removeWhere((chat) => chat.id == chatId);
    _filterChats(searchQuery.value);
  }

  void setTypingStatus(String chatId, bool isTyping) {
    typingStatus[chatId] = isTyping;
  }

  String getInitials(String name) {
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  Color getInitialsColor(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    return colors[name.hashCode % colors.length];
  }
}

class ChatThread {
  final String id;
  final String participantName;
  final String participantAvatar;
  final String jobTitle;
  final String jobIcon;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  final bool isPinned;
  final bool hasAttachment;
  final bool isRead;
  final MessageType messageType;

  ChatThread({
    required this.id,
    required this.participantName,
    required this.participantAvatar,
    required this.jobTitle,
    required this.jobIcon,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
    required this.isPinned,
    required this.hasAttachment,
    required this.isRead,
    required this.messageType,
  });

  ChatThread copyWith({
    String? id,
    String? participantName,
    String? participantAvatar,
    String? jobTitle,
    String? jobIcon,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    bool? isOnline,
    bool? isPinned,
    bool? hasAttachment,
    bool? isRead,
    MessageType? messageType,
  }) {
    return ChatThread(
      id: id ?? this.id,
      participantName: participantName ?? this.participantName,
      participantAvatar: participantAvatar ?? this.participantAvatar,
      jobTitle: jobTitle ?? this.jobTitle,
      jobIcon: jobIcon ?? this.jobIcon,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      isPinned: isPinned ?? this.isPinned,
      hasAttachment: hasAttachment ?? this.hasAttachment,
      isRead: isRead ?? this.isRead,
      messageType: messageType ?? this.messageType,
    );
  }
}

enum MessageType { text, image, document, voice }