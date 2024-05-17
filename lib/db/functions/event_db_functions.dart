// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/model/events_model.dart';

ValueNotifier<List<EventsModel>> eventListNotifier = ValueNotifier([]);

//! ADD EVENT
Future<void> addEventDetails(EventsModel value) async {
  final eventDB = await Hive.openBox<EventsModel>(EventsModel.boxName);
  
  final idKey = await eventDB.add(value);
  value.id = idKey;

  eventListNotifier.value.add(value);
  // notify listeners
  eventListNotifier.notifyListeners();
}

//! GET EVENT
Future<List<EventsModel>> fetchEvents() async {
  final eventDB = await Hive.openBox<EventsModel>(EventsModel.boxName);
  return eventDB.values.toList();
}
