import 'package:hive_flutter/hive_flutter.dart';
part 'task_steps_model.g.dart';

@HiveType(typeId: 5)
class TaskStepsModel {
   //box name
  static const String boxName = 'Task_step_db';

  @HiveField(0)
  int? id;

  @HiveField(1)
  final String step;

  TaskStepsModel({required this.step, this.id});

  get isChecked => null;
}