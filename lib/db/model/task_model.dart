import 'package:hive_flutter/adapters.dart';
import 'package:scribe/db/model/task_steps_model.dart';
// Type-adapter
part 'task_model.g.dart';

@HiveType(typeId: 2)
class TaskModel extends HiveObject{
  // task db
  static const String boxName = 'Task_db';

  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;
  
  @HiveField(2)
  String description;

  @HiveField(3)
  final List<TaskStepsModel> taskStepsList;

  TaskModel({this.id, required this.name, required this.description,required this.taskStepsList});

  get isChecked => null;
}