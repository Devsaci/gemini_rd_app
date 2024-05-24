import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;

class ChatProvider extends ChangeNotifier {
  // Init Hive boxe
  static initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    //await Hive.initFlutter();
  }
}
