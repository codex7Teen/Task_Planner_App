// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scribe/db/model/login_model.dart';

ValueNotifier<List<LoginModel>> loginListNotifier = ValueNotifier([]);

//  ChangeNotifier is a class that provides change notification to its listeners.
class LoginFunctions extends ChangeNotifier {
//! ADD LOGIN
  Future<void> addLoginDetails(LoginModel value) async {
    final loginDB = await Hive.openBox<LoginModel>(LoginModel.boxName);
    // clearing database
    await loginDB.clear();
    // clearing loginListNotifier list
    loginListNotifier.value.clear();
    // adding values to DB
    await loginDB.add(value);
    loginListNotifier.value.add(value);
    // notifying listeners
    loginListNotifier.notifyListeners();
  }

//! GET LOGIN
  Future<void> getLoginDetails() async {
    final loginDB = await Hive.openBox<LoginModel>(LoginModel.boxName);
    loginListNotifier.value.clear();

    loginListNotifier.value.addAll(loginDB.values);
    // notifying listeners
    loginListNotifier.notifyListeners();
  }

//! USER LOGGED IN CHECK
  Future<bool> checkLogin() async {
    final loginDB = await Hive.openBox<LoginModel>(LoginModel.boxName);
    return loginDB.length > 0;
  }
}
