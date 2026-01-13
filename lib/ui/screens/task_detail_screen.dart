import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/task.dart';
import '../../domain/models/connection.dart';
import '../../domain/models/enums.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/task_repository_impl.dart';
import '../../persistence/connection_repository_impl.dart';
import '../../persistence/goal_repository_impl.dart';
import '../../persistence/list_repository_impl.dart';
import '../../persistence/list_item_repository_impl.dart';
import '../widgets/connection_selector.dart';
import 'task_form_screen.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late Task _task;
  List<Connection> _goalConnections = [];
  List<Connection> _listConnections = [];
  List<Connection> _listItemConnections = [];
  Map<String, String> _goalNames = {};
  Map<String, String> _listNames = {};
  Map<String, String> _listItemNames = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
    _loadConnections();
  }

  Future<void> _loadConnections() async {
    setState(() {
      _isLoading = true;
    });

    final database = db.AppDatabase();
    final connectionRepo = ConnectionRepositoryImpl(database);
    final goalRepo = GoalRepositoryImpl(database);
    final listRepo = ListRepositoryImpl(database);
    final listItemRepo = ListItemRepositoryImpl(database);

    try {
      // Get all connections for this task
      final connections = await connectionRepo.getConnectionsForNode(_task.id);

      // Separate by type
      final goalConns = connections.where((c) =>
          c.relationshipType == RelationshipType.goalToTask &&
          c.toNodeId == _task.id).toList();
      final listConns = connections.where((c) =>
          c.relationshipType == RelationshipType.taskToList &&
          c.fromNodeId == _task.id).toList();
      final listItemConns = connections.where((c) =>
          c.relationshipType == RelationshipType.taskToListItem &&
          c.fromNodeId == _task.id).toList();

      // Load names for each connected entity
      final goalNames = <String, String>{};
      for (final conn in goalConns) {
        final goal = await goalRepo.getGoalById(conn.fromNodeId);
        if (goal != null) {
          goalNames[conn.fromNodeId] = goal.name;
        }
      }

      final listNames = <String, String>{};
      for (final conn in listConns) {
        final list = await listRepo.getListById(conn.toNodeId);
        if (list != null) {
          listNames[conn.toNodeId] = list.name;
        }
      }

      final listItemNames = <String, String>{};
      for (final conn in listItemConns) {
        final item = await listItemRepo.getListItemById(conn.toNodeId);
        if (item != null) {
          listItemNames[conn.toNodeId] = item.title;
        }
      }

      setState(() {
        _goalConnections = goalConns;
        _listConnections = listConns;
        _listItemConnections = listItemConns;
        _goalNames = goalNames;
        _listNames = listNames;
        _listItemNames = listItemNames;
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

  Future<void> _toggleTaskCompletion() async {
    final database = db.AppDatabase();
    final repository = TaskRepositoryImpl(database);

    try {
      final updatedTask = _task.copyWith(
        isCompleted: !_task.isCompleted,
        updatedAt: DateTime.now(),
      );
      await repository.updateTask(updatedTask);
      setState(() {
        _task = updatedTask;
      });
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

  Future<void> _navigateToEdit() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(task: _task),
      ),
    );

    if (result == true) {
      // Reload task from database
      final database = db.AppDatabase();
      final repository = TaskRepositoryImpl(database);
      try {
        final updatedTask = await repository.getTaskById(_task.id);
        if (updatedTask != null) {
          setState(() {
            _task = updatedTask;
          });
        }
      } finally {
        await database.close();
      }
    }
  }

  Future<void> _addGoalConnection() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConnectionSelector(
          nodeType: NodeType.goal,
          excludeIds: _goalNames.keys.toList(),
          onSelected: (goalId, goalName) async {
            await _createConnection(
              fromNodeId: goalId,
              toNodeId: _task.id,
              relationshipType: RelationshipType.goalToTask,
            );
          },
        ),
      ),
    );
  }

  Future<void> _addListConnection() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConnectionSelector(
          nodeType: NodeType.list,
          excludeIds: _listNames.keys.toList(),
          onSelected: (listId, listName) async {
            await _createConnection(
              fromNodeId: _task.id,
              toNodeId: listId,
              relationshipType: RelationshipType.taskToList,
            );
          },
        ),
      ),
    );
  }

  Future<void> _addListItemConnection() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConnectionSelector(
          nodeType: NodeType.listItem,
          excludeIds: _listItemNames.keys.toList(),
          onSelected: (itemId, itemName) async {
            await _createConnection(
              fromNodeId: _task.id,
              toNodeId: itemId,
              relationshipType: RelationshipType.taskToListItem,
            );
          },
        ),
      ),
    );
  }

  Future<void> _createConnection({
    required String fromNodeId,
    required String toNodeId,
    required RelationshipType relationshipType,
  }) async {
    final database = db.AppDatabase();
    final repository = ConnectionRepositoryImpl(database);

    try {
      final connection = Connection(
        id: const Uuid().v4(),
        fromNodeId: fromNodeId,
        toNodeId: toNodeId,
        relationshipType: relationshipType,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await repository.createConnection(connection);
      _loadConnections();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connection added')),
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

  Widget _buildConnectionSection({
    required String title,
    required IconData icon,
    required List<Connection> connections,
    required Map<String, String> names,
    required VoidCallback onAdd,
    required String Function(Connection) getEntityId,
  }) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: onAdd,
                  tooltip: 'Add $title',
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (connections.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'No $title connected',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              )
            else
              ...connections.map((conn) {
                final entityId = getEntityId(conn);
                final name = names[entityId] ?? 'Unknown';
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(icon, size: 16),
                  title: Text(name),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
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
                  // Task completion status
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    color: _task.isCompleted
                        ? Colors.green.withOpacity(0.1)
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            _task.isCompleted
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            size: 48,
                            color: _task.isCompleted ? Colors.green : null,
                          ),
                          onPressed: _toggleTaskCompletion,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _task.isCompleted ? 'Completed' : 'Not Completed',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  // Task metadata
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _task.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          'Timeframe',
                          _task.timeframe.name,
                          Icons.calendar_today,
                        ),
                        _buildInfoRow(
                          'Completion Type',
                          _task.completionRuleType.name,
                          Icons.rule,
                        ),
                        if (_task.description != null &&
                            _task.description!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(_task.description!),
                        ],
                      ],
                    ),
                  ),
                  const Divider(),
                  // Connected goals
                  _buildConnectionSection(
                    title: 'Goals',
                    icon: Icons.flag_outlined,
                    connections: _goalConnections,
                    names: _goalNames,
                    onAdd: _addGoalConnection,
                    getEntityId: (conn) => conn.fromNodeId,
                  ),
                  // Connected lists
                  _buildConnectionSection(
                    title: 'Lists',
                    icon: Icons.list_outlined,
                    connections: _listConnections,
                    names: _listNames,
                    onAdd: _addListConnection,
                    getEntityId: (conn) => conn.toNodeId,
                  ),
                  // Connected list items
                  _buildConnectionSection(
                    title: 'List Items',
                    icon: Icons.check_box_outlined,
                    connections: _listItemConnections,
                    names: _listItemNames,
                    onAdd: _addListItemConnection,
                    getEntityId: (conn) => conn.toNodeId,
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
