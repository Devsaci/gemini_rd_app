import 'package:hive_flutter/hive_flutter.dart';

import 'chat_history.dart';
import 'user_model.dart';

class Boxes {
  // get the caht history box
  static Box<ChatHistory> getChatHistory() =>
      Hive.box<ChatHistory>('chat_history');

  // get user box
  static Box<UserModel> getUser() => Hive.box<UserModel>('user');
}
