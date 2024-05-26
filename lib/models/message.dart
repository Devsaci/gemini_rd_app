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
}

// toMap
// Map<String, dynamic> toMap(Message message) {
//   return {
//     'messageId': message.messageId,
//     'chatId': message.chatId,
//     'role': message.role.toString(),
//     'message': message.message.toString(),
//     'imagesUrls': message.imagesUrls,
//     'timeSent': message.timeSent.toString(),
//   };
// }

// fromMap

enum Role { user, assistant }
