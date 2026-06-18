import 'package:flutter/material.dart';
import '../../domain/models/goal.dart';
import '../../domain/models/enums.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/goal_repository_impl.dart';
import '../../persistence/connection_repository_impl.dart';
import '../../persistence/task_repository_impl.dart';
import 'goal_form_screen.dart';
import 'goal_detail_screen.dart';

class BucketListScreen extends StatefulWidget {
  const BucketListScreen({super.key});

  @override
  State<BucketListScreen> createState() => _BucketListScreenState();
}

class _BucketListScreenState extends State<BucketListScreen> {
  List<Goal> _goals = [];
  Map<String, double> _goalProgress = {};
  Map<String, int> _goalTaskCount = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    setState(() => _isLoading = true);

    final database = db.AppDatabase();
    final goalRepo = GoalRepositoryImpl(database);
    final connectionRepo = ConnectionRepositoryImpl(database);
    final taskRepo = TaskRepositoryImpl(database);

    try {
      final goals = await goalRepo.getAllGoals();
      final progress = <String, double>{};
      final taskCount = <String, int>{};

      for (final goal in goals) {
        final connections = await connectionRepo.getConnectionsFromNode(goal.id);
        final taskConns = connections
            .where((c) => c.relationshipType == RelationshipType.goalToTask)
            .toList();

        taskCount[goal.id] = taskConns.length;

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

      setState(() {
        _goals = goals;
        _goalProgress = progress;
        _goalTaskCount = taskCount;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading bucket list: $e')),
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
    if (result == true) _loadGoals();
  }

  Future<void> _navigateToDetail(Goal goal) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoalDetailScreen(goal: goal),
      ),
    );
    if (result == true) _loadGoals();
  }

  Future<void> _deleteGoal(Goal goal) async {
    final database = db.AppDatabase();
    final goalRepo = GoalRepositoryImpl(database);
    final connectionRepo = ConnectionRepositoryImpl(database);

    try {
      // Delete associated connections first
      final connections = await connectionRepo.getConnectionsForNode(goal.id);
      for (final conn in connections) {
        await connectionRepo.deleteConnection(conn.id);
      }
      await goalRepo.deleteGoal(goal.id);
      _loadGoals();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting item: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  bool _isGoalComplete(Goal goal) {
    if (!goal.autoCompleteEnabled) return goal.isManuallyCompleted;
    final count = _goalTaskCount[goal.id] ?? 0;
    if (count == 0) return goal.isManuallyCompleted;
    final progress = _goalProgress[goal.id] ?? 0;
    return progress >= 1.0;
  }

  List<Goal> get _sortedGoals {
    final incomplete = _goals.where((g) => !_isGoalComplete(g)).toList();
    final complete = _goals.where((g) => _isGoalComplete(g)).toList();
    return [...incomplete, ...complete];
  }

  @override
  Widget build(BuildContext context) {
    final sorted = _sortedGoals;
    final completedCount = _goals.where(_isGoalComplete).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bucket List'),
        centerTitle: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _goals.isEmpty
              ? _buildEmptyState()
              : Column(
                  children: [
                    _buildStatsBar(completedCount),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _loadGoals,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                          itemCount: sorted.length,
                          itemBuilder: (context, index) {
                            final goal = sorted[index];
                            return _buildGoalCard(goal);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
    );
  }

  Widget _buildStatsBar(int completedCount) {
    final total = _goals.length;
    final pct = total == 0 ? 0.0 : completedCount / total;

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$completedCount of $total completed',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const Spacer(),
              Text(
                '${(pct * 100).toInt()}%',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: pct,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(Goal goal) {
    final isComplete = _isGoalComplete(goal);
    final taskCount = _goalTaskCount[goal.id] ?? 0;
    final progress = _goalProgress[goal.id];
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: Key(goal.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 28),
            SizedBox(height: 4),
            Text('Delete', style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Item'),
            content: Text('Remove "${goal.name}" from your bucket list?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => _deleteGoal(goal),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: isComplete ? 0 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isComplete
              ? BorderSide(color: Colors.green.shade300, width: 1.5)
              : BorderSide.none,
        ),
        color: isComplete
            ? Colors.green.withOpacity(0.05)
            : colorScheme.surface,
        child: InkWell(
          onTap: () => _navigateToDetail(goal),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Completion icon
                    GestureDetector(
                      onTap: () => _navigateToDetail(goal),
                      child: Icon(
                        isComplete
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: isComplete
                            ? Colors.green
                            : colorScheme.onSurfaceVariant,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goal.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  decoration: isComplete
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: isComplete
                                      ? colorScheme.onSurfaceVariant
                                      : colorScheme.onSurface,
                                ),
                          ),
                          if (goal.description != null &&
                              goal.description!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              goal.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Edit button
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      onPressed: () => _navigateToForm(goal: goal),
                      color: colorScheme.onSurfaceVariant,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                // Progress section
                if (taskCount > 0) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progress ?? 0,
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(2),
                          backgroundColor:
                              colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isComplete ? Colors.green : colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${((progress ?? 0) * 100).toInt()}%',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$taskCount step${taskCount == 1 ? '' : 's'}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ] else if (goal.timeframe != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        goal.timeframe!.name[0].toUpperCase() +
                            goal.timeframe!.name.substring(1),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_border_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            ),
            const SizedBox(height: 24),
            Text(
              'Your bucket list is empty',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Add things you want to do, experience, or achieve in life.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => _navigateToForm(),
              icon: const Icon(Icons.add),
              label: const Text('Add First Item'),
            ),
          ],
        ),
      ),
    );
  }
}
