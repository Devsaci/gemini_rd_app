class Message {
  String messageId;
  String chatId;
  Role role;
  StringBuffer message;

  Message({
    required this.messageId,
    required this.chatId,
    required this.role,
    required this.message,
  });
}

enum Role { user, assistant }
