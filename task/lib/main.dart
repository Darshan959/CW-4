import 'package:flutter/material.dart';

// Task model class
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  // Method to add a new task
  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: _taskController.text));
        _taskController.clear();
      });
    }
  }

  // Method to toggle task completion status
  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  // Method to delete a task
  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field and Add button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter Task Name',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Task List
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        _toggleTaskCompletion(task);
                      },
                    ),
                    title: Text(task.name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTask(task),
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
}
