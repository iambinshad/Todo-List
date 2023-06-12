import 'package:hive_flutter/hive_flutter.dart';
part 'todo_list_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  final String description;
// @HiveField(3)
//   bool value;
  TodoModel({required this.title, required this.description });
}
