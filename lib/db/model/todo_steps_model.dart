import 'package:hive_flutter/hive_flutter.dart';
part 'todo_steps_model.g.dart';

@HiveType(typeId: 6)
class TodoStepsModel {
   //box name
  static const String boxName = 'Todo_step_db';

  @HiveField(0)
  int? id;

  @HiveField(2)
  final String stepTodo;

  TodoStepsModel({required this.stepTodo, this.id});
}