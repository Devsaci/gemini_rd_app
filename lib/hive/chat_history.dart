import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class ChatHistory {
  @HiveField(0)
  final String chatId;

  @HiveField(1)
  final String prompt;

  @HiveField(2)
  final String response;

  ChatHistory({
    required this.chatId,
    required this.prompt,
    required this.response,
  });
}
