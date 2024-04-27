// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scribe/db/model/notes_model.dart';

ValueNotifier<List<NotesModel>> notesListNotifier = ValueNotifier([]);

//! ADD NOTE
Future<void> addNotesDetails(NotesModel value) async {
  final notesDB = await Hive.openBox<NotesModel>(NotesModel.boxName);

  // add to db
  final idKey = await notesDB.add(value);
  value.id = idKey;

  // add to list
  notesListNotifier.value.add(value);
  // notify listeners
  notesListNotifier.notifyListeners();
}

//! GET NOTE
Future<void> getNotesDetails() async {
  final notesDB = await Hive.openBox<NotesModel>(NotesModel.boxName);

  notesListNotifier.value.clear();
  notesListNotifier.value.addAll(notesDB.values);
  // notifying listeners
  notesListNotifier.notifyListeners();
}

//! DELETE NOTE
Future<void> deleteNotes(int id) async {
   final notesDB = await Hive.openBox<NotesModel>(NotesModel.boxName);
    await notesDB.delete(id);
    getNotesDetails();
}
