import 'package:get/get.dart';

class ChatDetailController extends GetxController {
  final RxBool isOnline = false.obs;
  final RxBool isTyping = false.obs;
  final RxString replyingToMessage = ''.obs;
  final RxString selectedMessageId = ''.obs;

  void setOnlineStatus(bool status) {
    isOnline.value = status;
  }

  void setTypingStatus(bool status) {
    isTyping.value = status;
  }

  void startTypingSimulation() {
    // Simulate typing after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setTypingStatus(true);
      Future.delayed(const Duration(seconds: 2), () {
        setTypingStatus(false);
      });
    });
  }

  void setReplyingTo(String messageId, String messageText) {
    replyingToMessage.value = messageText;
    selectedMessageId.value = messageId;
  }

  void clearReply() {
    replyingToMessage.value = '';
    selectedMessageId.value = '';
  }

  void showMessageOptions(String messageId) {
    // Handle message long press options
  }
}