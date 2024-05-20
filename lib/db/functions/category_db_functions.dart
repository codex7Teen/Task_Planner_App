// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scribe/db/model/category_model.dart';

ValueNotifier<List<CategoryModel>> categoryNotifier = ValueNotifier([]);

// Shared valuenotifier for accessing categories in other parts of app
ValueNotifier<List<String>> categoryListNotifier = ValueNotifier([]);

//! ADD CATEGORY
Future<void> addCategory(CategoryModel value) async {
  final categoryDB = await Hive.openBox<CategoryModel>(CategoryModel.boxName);
  // add to db
  await categoryDB.add(value);

  // add to valuenotifier
  categoryNotifier.value.add(value);

  // notify listeners
  categoryNotifier.notifyListeners();
}

//! GET ALL CATEGORY
Future<void> getCategoryDetails() async {
  final categoryDB = await Hive.openBox<CategoryModel>(CategoryModel.boxName);
// clearing notifier list
  categoryNotifier.value.clear();
// adding values to notifier list
  categoryNotifier.value.addAll(categoryDB.values);
// notifying listeners
  categoryNotifier.notifyListeners();
}

//! DELETE CATEGORY
Future<void> deleteCategory(int id) async {
   final categoryDB = await Hive.openBox<CategoryModel>(CategoryModel.boxName);
    await categoryDB.delete(id);
    // Refresh the category-list notifier
    getCategoryDetails();
}
