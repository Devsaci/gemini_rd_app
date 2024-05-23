import 'package:hive_flutter/hive_flutter.dart';

import 'chat_history.dart';

class Boxes {
  // get the caht history box
  static Box<ChatHistory> getChatHistory() =>
      Hive.box<ChatHistory>('chat_history');
}
