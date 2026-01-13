import 'package:flutter/material.dart';
import '../../domain/models/goal.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/goal_repository_impl.dart';
import '../../persistence/connection_repository_impl.dart';
import '../../persistence/task_repository_impl.dart';
import '../../domain/models/enums.dart';
import 'goal_form_screen.dart';
import 'goal_detail_screen.dart';

class GoalListScreen extends StatefulWidget {
  const GoalListScreen({super.key});

  @override
  State<GoalListScreen> createState() => _GoalListScreenState();
}

class _GoalListScreenState extends State<GoalListScreen> {
  List<Goal> _goals = [];
  Map<String, double> _goalProgress = {}; // goalId -> progress (0.0 to 1.0)
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    setState(() {
      _isLoading = true;
    });

    final database = db.AppDatabase();
    final goalRepo = GoalRepositoryImpl(database);
    final connectionRepo = ConnectionRepositoryImpl(database);
    final taskRepo = TaskRepositoryImpl(database);

    try {
      final goals = await goalRepo.getAllGoals();

      // Calculate progress for each goal
      final progress = <String, double>{};
      for (final goal in goals) {
        if (goal.autoCompleteEnabled) {
          final connections = await connectionRepo.getConnectionsFromNode(goal.id);
          final taskConns = connections
              .where((c) => c.relationshipType == RelationshipType.goalToTask)
              .toList();

          if (taskConns.isNotEmpty) {
            var completedCount = 0;
            for (final conn in taskConns) {
              final task = await taskRepo.getTaskById(conn.toNodeId);
              if (task != null && task.isCompleted) {
                completedCount++;
              }
            }
            progress[goal.id] = completedCount / taskConns.length;
          }
        }
      }

      setState(() {
        _goals = goals;
        _goalProgress = progress;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading goals: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  Future<void> _navigateToForm({Goal? goal}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoalFormScreen(goal: goal),
      ),
    );

    if (result == true) {
      _loadGoals();
    }
  }

  Future<void> _navigateToDetail(Goal goal) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoalDetailScreen(goal: goal),
      ),
    );

    if (result == true) {
      _loadGoals();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _goals.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No goals yet',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap the + button to create your first goal',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _goals.length,
                  itemBuilder: (context, index) {
                    final goal = _goals[index];
                    final progress = _goalProgress[goal.id];
                    final isComplete = goal.autoCompleteEnabled
                        ? (progress != null && progress >= 1.0)
                        : goal.isManuallyCompleted;

                    String subtitle = goal.timeframe?.name ?? '';
                    if (goal.autoCompleteEnabled && progress != null) {
                      subtitle = '${subtitle.isNotEmpty ? "$subtitle • " : ""}${(progress * 100).toInt()}% complete';
                    } else if (!goal.autoCompleteEnabled) {
                      subtitle = '${subtitle.isNotEmpty ? "$subtitle • " : ""}Manual completion';
                    }

                    return ListTile(
                      leading: Icon(
                        isComplete ? Icons.check_circle : Icons.flag_outlined,
                        color: isComplete ? Colors.green : null,
                      ),
                      title: Text(
                        goal.name,
                        style: isComplete
                            ? TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              )
                            : null,
                      ),
                      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateToForm(goal: goal),
                      ),
                      onTap: () => _navigateToDetail(goal),
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
