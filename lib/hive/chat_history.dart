import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class ChatHistory {
  @HiveField(0)
  final String chatId;

  ChatHistory({required this.chatId});
}
