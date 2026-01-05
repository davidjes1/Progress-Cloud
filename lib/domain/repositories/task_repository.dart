import '../models/task.dart';

/// Repository interface for Task data access
abstract class TaskRepository {
  /// Get all tasks
  Future<List<Task>> getAllTasks();

  /// Get a task by ID
  Future<Task?> getTaskById(String id);

  /// Get tasks by timeframe
  Future<List<Task>> getTasksByTimeframe(String timeframe);

  /// Create a new task
  Future<void> createTask(Task task);

  /// Update an existing task
  Future<void> updateTask(Task task);

  /// Delete a task
  Future<void> deleteTask(String id);

  /// Watch all tasks (stream)
  Stream<List<Task>> watchAllTasks();

  /// Watch a specific task (stream)
  Stream<Task?> watchTask(String id);
}
