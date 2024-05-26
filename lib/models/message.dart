class Message {
  String messageId;
  String chatId;
  Role role;
  StringBuffer message;
  List<String> imagesUrls;
  DateTime timeSent;

  Message({
    required this.messageId,
    required this.chatId,
    required this.role,
    required this.message,
    required this.imagesUrls,
    required this.timeSent,
  });

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'chatId': chatId,
      'role': role.toString(),
      'message': message.toString(),
      'imagesUrls': imagesUrls,
      'timeSent': timeSent.toString(),
    };
  }

  // fromMap
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'],
      chatId: map['chatId'],
      role: Role.values
          .firstWhere((element) => element.toString() == map['role']),
      message: StringBuffer(map['message']),
      imagesUrls: List<String>.from(map['imagesUrls']),
      timeSent: DateTime.parse(map['timeSent']),
    );
  }

// copyWith
  Message copyWith({
    String? messageId,
    String? chatId,
    Role? role,
    StringBuffer? message,
    List<String>? imagesUrls,
    DateTime? timeSent,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      role: role ?? this.role,
      message: message ?? this.message,
      imagesUrls: imagesUrls ?? this.imagesUrls,
      timeSent: timeSent ?? this.timeSent,
    );
  }
}

enum Role { user, assistant }
