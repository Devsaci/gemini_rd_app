import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String name;

  UserModel({
    required this.uid,
    required this.name,
  });
}
