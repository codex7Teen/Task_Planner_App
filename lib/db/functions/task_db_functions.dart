// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/model/task_model.dart';

ValueNotifier<List<TaskModel>> taskListNotifier = ValueNotifier([]);

//  ChangeNotifier is a class that provides change notification to its listeners.
class TaskFunctions extends ChangeNotifier {
//! ADD TASK
  Future<void> addTaskDetails(TaskModel value) async {
    // Open the Hive box for TaskModel
    final taskDB = await Hive.openBox<TaskModel>(TaskModel.boxName);

    // add to db
    await taskDB.add(value);

    // add to list
    taskListNotifier.value.add(value);
    // notify listeners
    taskListNotifier.notifyListeners();
  }

//! GET TASK
  Future<void> getTaskDetails() async {
    final taskDB = await Hive.openBox<TaskModel>(TaskModel.boxName);
    taskListNotifier.value.clear();

    taskListNotifier.value.addAll(taskDB.values);
    // notifying listeners
    taskListNotifier.notifyListeners();
  }

//! DELETE TASK
  Future<void> deleteTask(int id) async {
    final taskDB = await Hive.openBox<TaskModel>(TaskModel.boxName);
    await taskDB.delete(id);
    // Refresh the task list notifier
    getTaskDetails();
  }

//! UPDATE TASK
  Future<void> updateTask(int id, TaskModel newValue) async {
    final taskDB = await Hive.openBox<TaskModel>(TaskModel.boxName);

    // update the existing task wiith the new value using the ID provided
    await taskDB.put(id, newValue);
    // Refresh the task list notifier
    getTaskDetails();
  }
}
