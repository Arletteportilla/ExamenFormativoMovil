import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_formativo_movil/providers/task_provider.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Tareas',
          style: TextStyle(
            fontSize: 24, // Increase font size
            fontWeight: FontWeight.bold, // Make it bold
          ),
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return Card(
                elevation: 4, // Add elevation for a card-like appearance
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size
                      fontWeight: FontWeight.bold, // Make it bold
                    ),
                  ),
                  subtitle: Text(
                    task.description,
                    style: TextStyle(
                      fontSize: 14, // Adjust the font size
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          taskProvider.toggleTaskDone(task.id);
                        },
                        value: task.isDone,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red, // Change the delete button color
                        ),
                        onPressed: () {
                          taskProvider.removeTask(task.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    showTaskDialog(
                      context,
                      task: task,
                      taskProvider: taskProvider,
                    );
                  },
                  onLongPress: () {
                    taskProvider.removeTask(task.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTaskDialog(
            context,
            taskProvider: Provider.of<TaskProvider>(context, listen: false),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
