import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/goal.dart';
import '../../domain/models/task.dart';
import '../../domain/models/connection.dart';
import '../../domain/models/enums.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/goal_repository_impl.dart';
import '../../persistence/task_repository_impl.dart';
import '../../persistence/connection_repository_impl.dart';
import '../widgets/connection_selector.dart';
import 'goal_form_screen.dart';

class GoalDetailScreen extends StatefulWidget {
  final Goal goal;

  const GoalDetailScreen({
    super.key,
    required this.goal,
  });

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  late Goal _goal;
  List<Connection> _taskConnections = [];
  Map<String, Task> _tasks = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _goal = widget.goal;
    _loadConnections();
  }

  Future<void> _loadConnections() async {
    setState(() {
      _isLoading = true;
    });

    final database = db.AppDatabase();
    final connectionRepo = ConnectionRepositoryImpl(database);
    final taskRepo = TaskRepositoryImpl(database);

    try {
      // Get all task connections for this goal
      final connections = await connectionRepo.getConnectionsFromNode(_goal.id);
      final taskConns = connections
          .where((c) => c.relationshipType == RelationshipType.goalToTask)
          .toList();

      // Load task details
      final tasks = <String, Task>{};
      for (final conn in taskConns) {
        final task = await taskRepo.getTaskById(conn.toNodeId);
        if (task != null) {
          tasks[conn.toNodeId] = task;
        }
      }

      setState(() {
        _taskConnections = taskConns;
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading connections: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  Future<void> _toggleManualCompletion() async {
    final database = db.AppDatabase();
    final repository = GoalRepositoryImpl(database);

    try {
      final updatedGoal = _goal.copyWith(
        isManuallyCompleted: !_goal.isManuallyCompleted,
        updatedAt: DateTime.now(),
      );
      await repository.updateGoal(updatedGoal);
      setState(() {
        _goal = updatedGoal;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating goal: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  Future<void> _toggleAutoComplete() async {
    final database = db.AppDatabase();
    final repository = GoalRepositoryImpl(database);

    try {
      final updatedGoal = _goal.copyWith(
        autoCompleteEnabled: !_goal.autoCompleteEnabled,
        updatedAt: DateTime.now(),
      );
      await repository.updateGoal(updatedGoal);
      setState(() {
        _goal = updatedGoal;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating goal: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  Future<void> _navigateToEdit() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoalFormScreen(goal: _goal),
      ),
    );

    if (result == true) {
      // Reload goal from database
      final database = db.AppDatabase();
      final repository = GoalRepositoryImpl(database);
      try {
        final updatedGoal = await repository.getGoalById(_goal.id);
        if (updatedGoal != null) {
          setState(() {
            _goal = updatedGoal;
          });
        }
      } finally {
        await database.close();
      }
    }
  }

  Future<void> _addTaskConnection() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConnectionSelector(
          nodeType: NodeType.task,
          excludeIds: _tasks.keys.toList(),
          onSelected: (taskId, taskName) async {
            await _createConnection(taskId);
          },
        ),
      ),
    );
  }

  Future<void> _createConnection(String taskId) async {
    final database = db.AppDatabase();
    final repository = ConnectionRepositoryImpl(database);

    try {
      final connection = Connection(
        id: const Uuid().v4(),
        fromNodeId: _goal.id,
        toNodeId: taskId,
        relationshipType: RelationshipType.goalToTask,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await repository.createConnection(connection);
      _loadConnections();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task connected')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating connection: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  Future<void> _removeConnection(String connectionId) async {
    final database = db.AppDatabase();
    final repository = ConnectionRepositoryImpl(database);

    try {
      await repository.deleteConnection(connectionId);
      _loadConnections();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connection removed')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error removing connection: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  double _calculateProgress() {
    if (_tasks.isEmpty) return 0.0;
    final completedCount = _tasks.values.where((task) => task.isCompleted).length;
    return completedCount / _tasks.length;
  }

  bool _shouldShowAsComplete() {
    if (!_goal.autoCompleteEnabled) {
      return _goal.isManuallyCompleted;
    }
    // Auto-complete: check if all tasks are complete
    if (_tasks.isEmpty) return _goal.isManuallyCompleted;
    return _tasks.values.every((task) => task.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    final progress = _calculateProgress();
    final isComplete = _shouldShowAsComplete();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEdit,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Completion status header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    color: isComplete
                        ? Colors.green.withOpacity(0.1)
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Column(
                      children: [
                        Icon(
                          isComplete ? Icons.check_circle : Icons.flag_outlined,
                          size: 48,
                          color: isComplete ? Colors.green : null,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isComplete ? 'Completed' : 'In Progress',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        if (_goal.autoCompleteEnabled && _tasks.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${(progress * 100).toInt()}% Complete',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Goal metadata
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _goal.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        if (_goal.timeframe != null)
                          _buildInfoRow(
                            'Timeframe',
                            _goal.timeframe!.name,
                            Icons.calendar_today,
                          ),
                        if (_goal.description != null &&
                            _goal.description!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(_goal.description!),
                        ],
                      ],
                    ),
                  ),
                  const Divider(),
                  // Auto-complete settings
                  Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.settings, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Completion Settings',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Auto-complete when all tasks done'),
                            subtitle: Text(
                              _goal.autoCompleteEnabled
                                  ? 'Goal completes automatically when all connected tasks are done'
                                  : 'Use manual completion toggle below',
                            ),
                            value: _goal.autoCompleteEnabled,
                            onChanged: (value) => _toggleAutoComplete(),
                          ),
                          if (!_goal.autoCompleteEnabled) ...[
                            const Divider(),
                            SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Manually mark as complete'),
                              value: _goal.isManuallyCompleted,
                              onChanged: (value) => _toggleManualCompletion(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  // Connected tasks
                  Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.task_outlined, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Connected Tasks',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: _addTaskConnection,
                                tooltip: 'Add Task',
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (_tasks.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'No tasks connected',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            )
                          else
                            ..._taskConnections.map((conn) {
                              final task = _tasks[conn.toNodeId];
                              if (task == null) return const SizedBox.shrink();
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  task.isCompleted
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  color: task.isCompleted ? Colors.green : null,
                                  size: 20,
                                ),
                                title: Text(
                                  task.title,
                                  style: task.isCompleted
                                      ? TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        )
                                      : null,
                                ),
                                subtitle: Text(
                                  '${task.timeframe.name} • ${task.completionRuleType.name}',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => _removeConnection(conn.id),
                                  tooltip: 'Remove',
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
