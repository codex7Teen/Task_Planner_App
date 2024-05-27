import 'package:hive_flutter/adapters.dart';

// Type-adapter
part 'category_model.g.dart';

@HiveType(typeId: 8)
class CategoryModel extends HiveObject {
  //box name
  static const String boxName = 'Category_db';

  @HiveField(0)
  String category;

  CategoryModel({required this.category});
}
