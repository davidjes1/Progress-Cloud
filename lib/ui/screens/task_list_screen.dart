import 'package:flutter/material.dart';
import '../../domain/models/task.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/task_repository_impl.dart';
import 'task_form_screen.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
    });

    final database = db.AppDatabase();
    final repository = TaskRepositoryImpl(database);

    try {
      final tasks = await repository.getAllTasks();
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading tasks: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  Future<void> _navigateToForm({Task? task}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(task: task),
      ),
    );

    if (result == true) {
      _loadTasks();
    }
  }

  Future<void> _navigateToDetail(Task task) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(task: task),
      ),
    );

    if (result == true) {
      _loadTasks();
    }
  }

  Future<void> _toggleTaskCompletion(Task task) async {
    final database = db.AppDatabase();
    final repository = TaskRepositoryImpl(database);

    try {
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
        updatedAt: DateTime.now(),
      );
      await repository.updateTask(updatedTask);
      _loadTasks();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating task: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.task_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No tasks yet',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap the + button to create your first task',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return ListTile(
                      leading: IconButton(
                        icon: Icon(
                          task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                          color: task.isCompleted ? Colors.green : null,
                        ),
                        onPressed: () => _toggleTaskCompletion(task),
                      ),
                      title: Text(
                        task.title,
                        style: task.isCompleted
                            ? TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              )
                            : null,
                      ),
                      subtitle: Text(
                        '${task.timeframe.name} • ${task.completionRuleType.name}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateToForm(task: task),
                      ),
                      onTap: () => _navigateToDetail(task),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
