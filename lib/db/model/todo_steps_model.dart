import 'package:hive_flutter/hive_flutter.dart';
part 'todo_steps_model.g.dart';

@HiveType(typeId: 6)
class TodoStepsModel {
  //box name
  static const String boxName = 'Todo_step_db';

  @HiveField(1)
  final String stepTodo;

  @HiveField(2)
  bool isTodoChecked;

  TodoStepsModel({required this.stepTodo, this.isTodoChecked = false});
}
