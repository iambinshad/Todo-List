import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class todoModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String title;
  // @HiveField(2)
  // final String 
  todoModel(this.title);
}
