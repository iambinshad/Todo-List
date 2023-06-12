import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/db_provider.dart';
import 'package:todo_list/model/todo_list_model.dart';
import 'package:todo_list/view/todo_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => TodoDBProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
    
        
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  TodoListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
