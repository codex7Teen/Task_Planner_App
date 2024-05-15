// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/model/todo_model.dart';

ValueNotifier<List<TodoModel>> todoListNotifier = ValueNotifier([]);

//! ADD TASK
Future<void> addTodoDetails(TodoModel value) async {
  final todoDB = await Hive.openBox<TodoModel>(TodoModel.boxName);

  // add to db
  final idKey = await todoDB.add(value);
  value.id = idKey;

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