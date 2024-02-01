import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_formativo_movil/providers/task_provider.dart';
import 'package:examen_formativo_movil/screens/tasks_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
