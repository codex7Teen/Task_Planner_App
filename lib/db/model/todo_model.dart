import 'package:hive_flutter/adapters.dart';
import 'package:scribe/db/model/todo_steps_model.dart';
// Type-adapter
part 'todo_model.g.dart';

@HiveType(typeId: 4)
class TodoModel extends HiveObject{

  static const String boxName = 'Todo_box';

  @HiveField(0)
  String name;

  @HiveField(1)
  final List<TodoStepsModel> todoStepsList;

  @HiveField(2)
  bool todoFavorite;

  @HiveField(3)
  bool todoCheckBox;

  @HiveField(4)
  String? todoCategory;

  TodoModel({required this.name, required this.todoStepsList, this.todoFavorite = false, this.todoCheckBox = false, this.todoCategory});
} 