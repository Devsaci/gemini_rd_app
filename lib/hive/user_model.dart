import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String uid;

  UserModel({
    required this.uid,
  });
}
