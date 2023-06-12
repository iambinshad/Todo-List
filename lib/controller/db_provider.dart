import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/todo_list_model.dart';

class TodoDBProvider extends ChangeNotifier {
  List<TodoModel> todoListNotifier = [];
  bool checkboxDBState = false;

  Future<void> addTodoList(TodoModel value) async {
    final todoListDb = await Hive.openBox<TodoModel>('todo_Db');
    final id = await todoListDb.add(value);
    value.id = id;

    todoListNotifier.add(value);
    getAllTodoData();
    notifyListeners();
  }

  Future<void> getAllTodoData() async {
    final todoListDb = await Hive.openBox<TodoModel>('todo_Db');
    todoListNotifier.clear();
    todoListNotifier.addAll(todoListDb.values);
    notifyListeners();
  }
}
