import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/model/todo_model.dart';

ValueNotifier<List<TodoModel>> todoListNotifier = ValueNotifier([]);

//  ChangeNotifier is a class that provides change notification to its listeners.
class TodoFunctions extends ChangeNotifier {
//! ADD TODOS
  Future<void> addTodoDetails(TodoModel value) async {
    final todoDB = await Hive.openBox<TodoModel>(TodoModel.boxName);

    // add to db
    await todoDB.add(value);

    // add to list
    todoListNotifier.value.add(value);
    // notify listeners
    todoListNotifier.notifyListeners();
  }

// ! GET TODOS
  Future<void> getTodoDetails() async {
    final todoDB = await Hive.openBox<TodoModel>(TodoModel.boxName);
    todoListNotifier.value.clear();

    todoListNotifier.value.addAll(todoDB.values);
    // notifying listeners
    todoListNotifier.notifyListeners();
  }

//! DELETE TODOS
  Future<void> deleteTodo(int id) async {
    final todoDB = await Hive.openBox<TodoModel>(TodoModel.boxName);
    await todoDB.delete(id);
    getTodoDetails();
  }

  //! UPDATE TODOS
  Future<void> updateTodo(int id, TodoModel newValue) async {
    final todoDB = await Hive.openBox<TodoModel>(TodoModel.boxName);

    // update the existing todo wiith the new value using the ID provided
    await todoDB.put(id, newValue);
    // Refresh the todo list notifier
    getTodoDetails();
  }
}
