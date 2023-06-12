import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/db_provider.dart';
import 'package:todo_list/model/todo_list_model.dart';

import '../core/constant.dart';

class TodoListScreen extends StatefulWidget {
  TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

   TodoModel? checkbox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todoProvider = Provider.of<TodoDBProvider>(context);
    todoProvider.getAllTodoData();
    checkbox!.value = false;
  }

  @override
  Widget build(BuildContext context) {
        final todoProvider = Provider.of<TodoDBProvider>(context);


    return Scaffold(
      floatingActionButton: CircleAvatar(
        child: IconButton(
            onPressed: () {
              showAddAlertDialogue(context, todoProvider);
            },
            icon: const Icon(Icons.add)),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Todo List',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<TodoDBProvider>(
        builder: (context, value, child) => Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.todoListNotifier.length,
                itemBuilder: (context, index) {
                  final data = value.todoListNotifier[index];
                  return ListTile(
                    title: Text(
                      data.title,
                      style: textStyle20,
                    ),
                    subtitle: Text(
                      data.description,
                      style: textStyle15,
                    ),
                    trailing: Checkbox(
                      value: checkbox!.value,
                      onChanged: (bool? value) {
                        setState(() {
                          checkbox!.value = value ?? false;
                          checkbox!.save();
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddAlertDialogue(context, todoProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: const Text(
          'Add Todo List',
          style: TextStyle(color: Colors.red),
        ),
        content: Container(
          height: 160,
          width: 200,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                textAlign: TextAlign.left,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Title', border: OutlineInputBorder()),
              ),
              kHeight10,
              TextFormField(
                controller: descriptionController,
                textAlign: TextAlign.left,
                maxLines: 3,
                decoration: const InputDecoration(
                    hintText: 'discription', border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                saveButtonClicked(context, todoProvider);
              },
              child: const Text('Save')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
        ],
      ),
    );
  }

  void saveButtonClicked(context, todoProvider) {
    var title = titleController.text.trim();
    var description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      return;
    }

    final todoData =
        TodoModel(title: title, description: description,value:checkbox!.value);
    todoProvider.addTodoList(todoData);
    Navigator.pop(context);
  }
  
  // Future<void> openBox()async {
  //   checkbox = await Hive.openBox<TodoModel>('todo_Db');
  // }
}
