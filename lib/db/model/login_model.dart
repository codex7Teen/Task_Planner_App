import 'package:hive_flutter/hive_flutter.dart';
// Type-adapter
part 'login_model.g.dart';

@HiveType(typeId: 1)
class LoginModel {
  //box name
  static const String boxName = 'Login_db';

  @HiveField(0)
  final String name;

  LoginModel({required this.name});
}
