import 'package:hive_flutter/hive_flutter.dart';
part 'task_steps_model.g.dart';

@HiveType(typeId: 5)
class TaskStepsModel extends HiveObject{
   //box name
  static const String boxName = 'Task_step_db';

  @HiveField(0)
  final String step;

  @HiveField(1)
  bool isStepChecked;

  TaskStepsModel({required this.step, this.isStepChecked = false});

  get isChecked => null;
}