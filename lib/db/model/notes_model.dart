import 'package:hive_flutter/hive_flutter.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 3)
class NotesModel extends HiveObject{

// box name
static const String boxName = 'Notes_db';

@HiveField(0)
String name;

@HiveField(1)
String? note;

@HiveField(2)
bool isFavorite;

@HiveField(3)
String? notesCategory;

NotesModel({required this.name, this.note, this.isFavorite = false, this.notesCategory});
}