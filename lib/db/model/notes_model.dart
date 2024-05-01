import 'package:hive_flutter/hive_flutter.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 3)
class NotesModel {

// box name
static const String boxName = 'Notes_db';

@HiveField(0)
int? id;

@HiveField(1)
String name;

@HiveField(2)
String? note;

@HiveField(3)
bool isFavorite;

NotesModel({this.id, required this.name, this.note, this.isFavorite = false});
}