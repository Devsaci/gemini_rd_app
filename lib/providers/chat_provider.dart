import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatProvider extends ChangeNotifier {
  // Init Hive boxe
  static initHive() async {
    await Hive.initFlutter();
  }
}
