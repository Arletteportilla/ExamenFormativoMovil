import 'package:flutter/foundation.dart';
import 'package:examen_formativo_movil/models/task.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(String title, String description) {
    final task = Task(
        id: DateTime.now().toString(), title: title, description: description);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(String id, String title, String description) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = Task(
          id: id,
          title: title,
          description: description,
          isDone: _tasks[taskIndex].isDone);
      notifyListeners();
    }
  }

  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void toggleTaskDone(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isDone = !_tasks[taskIndex].isDone;
      notifyListeners();
    }
  }
}

void showTaskDialog(BuildContext context,
    {Task? task, required TaskProvider taskProvider}) {
  final titleController = TextEditingController(text: task?.title ?? '');
  final descriptionController =
      TextEditingController(text: task?.description ?? '');

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(task == null ? 'Añadir Tarea' : 'Editar Tarea'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Título'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Descripción'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Guardar'),
          onPressed: () {
            if (task == null) {
              taskProvider.addTask(
                  titleController.text, descriptionController.text);
            } else {
              taskProvider.updateTask(
                  task.id!, titleController.text, descriptionController.text);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
