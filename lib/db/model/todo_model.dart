import 'package:hive_flutter/adapters.dart';
import 'package:scribe/db/model/todo_steps_model.dart';
// Type-adapter
part 'todo_model.g.dart';

@HiveType(typeId: 4)
class TodoModel extends HiveObject{

  static const String boxName = 'Todo_box';

  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<TodoStepsModel> todoStepsList;

  TodoModel({required this.name, this.id, required this.todoStepsList});
}