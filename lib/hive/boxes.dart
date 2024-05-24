import 'package:gemini_rd_app/constants.dart';
import 'package:gemini_rd_app/hive/chat_history.dart';
import 'package:gemini_rd_app/hive/settings.dart';
import 'package:gemini_rd_app/hive/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  // get the caht history box
  static Box<ChatHistory> getChatHistory() =>
      Hive.box<ChatHistory>(Constants.chatHistoryBox);

  // get user box
  static Box<UserModel> getUser() => Hive.box<UserModel>(Constants.userBox);

  // get settings box
  static Box<Settings> getSettings() => Hive.box<Settings>('settings');
}
