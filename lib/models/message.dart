class Message {
  String messageId;
  String chatId;
  Role role;

  Message({
    required this.messageId,
    required this.chatId,
    required this.role,
  });
}

class Role {}
