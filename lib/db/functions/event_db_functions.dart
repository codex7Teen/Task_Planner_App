// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scribe/db/model/events_model.dart';

ValueNotifier<List<EventsModel>> eventListNotifier = ValueNotifier([]);

//! ADD EVENT
Future<void> addEventDetails(EventsModel value) async {
  final eventDB = await Hive.openBox<EventsModel>(EventsModel.boxName);

  await eventDB.add(value);

  eventListNotifier.value.add(value);
  // notify listeners
  eventListNotifier.notifyListeners();
}

//! GET EVENT
Future<List<EventsModel>> fetchEvents() async {
  final eventDB = await Hive.openBox<EventsModel>(EventsModel.boxName);
  return eventDB.values.toList();
}

//! UPDATE EVENT
Future<void> updateEvents(int key, EventsModel newValue) async {
  final eventDB = await Hive.openBox<EventsModel>(EventsModel.boxName);
  // update the existing event wiith the new value using the ID provided
  await eventDB.put(key, newValue);
 
  // refresh ui
  eventListNotifier.value.clear();
  // adding new-events to notifier-list after clearing the all eventlist inside notifier
  eventListNotifier.value.addAll(await fetchEvents());
   // notify listeners
  eventListNotifier.notifyListeners();
}

//! DELETE EVENT
