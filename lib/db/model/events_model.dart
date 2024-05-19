import 'package:hive_flutter/adapters.dart';

// Type-adapter
part 'events_model.g.dart';

@HiveType(typeId: 7)
class EventsModel extends HiveObject {
  //box name
  static const String boxName = 'Event_db';

  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime from;

  @HiveField(2)
  final DateTime to;

  @HiveField(3)
  String? description;

  EventsModel(
      {required this.name, required this.from, required this.to, this.description});
}
