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

  @HiveField(2)
  bool isStepChecked;

  TaskStepsModel({required this.step, this.id, this.isStepChecked = false});

  get isChecked => null;
}