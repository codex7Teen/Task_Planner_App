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

  // FAVORITE ICON
  @HiveField(4)
  bool isFavorite;

  // CHECKBOX 1
  @HiveField(5)
  bool isChecked1;
  
  // CHECKBOX 2
  @HiveField(6)
  bool isChecked2;

  TaskModel({this.id, required this.name, required this.description,required this.taskStepsList, this.isFavorite = false, this.isChecked1 = false, this.isChecked2 = false});

  get isChecked => null;
}