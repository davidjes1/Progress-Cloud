import '../models/goal.dart';
import '../models/enums.dart';
import '../repositories/goal_repository.dart';
import '../repositories/task_repository.dart';
import '../repositories/connection_repository.dart';

/// Service for managing hybrid goal completion logic
class GoalCompletionService {
  final GoalRepository _goalRepository;
  final TaskRepository _taskRepository;
  final ConnectionRepository _connectionRepository;

  GoalCompletionService({
    required GoalRepository goalRepository,
    required TaskRepository taskRepository,
    required ConnectionRepository connectionRepository,
  })  : _goalRepository = goalRepository,
        _taskRepository = taskRepository,
        _connectionRepository = connectionRepository;

  /// Check if a goal should auto-complete based on its connected tasks
  Future<bool> shouldAutoComplete(Goal goal) async {
    // If auto-complete is disabled, only manual completion applies
    if (!goal.autoCompleteEnabled) {
      return goal.isManuallyCompleted;
    }

    // If already manually completed, stay completed
    if (goal.isManuallyCompleted) {
      return true;
    }

    // Get all task connections for this goal
    final connections = await _connectionRepository.getConnectionsFromNode(goal.id);
    final taskConnections = connections
        .where((c) => c.relationshipType == RelationshipType.goalToTask)
        .toList();

    // If no tasks connected, can't auto-complete
    if (taskConnections.isEmpty) {
      return false;
    }

    // Check if all connected tasks are complete
    for (final conn in taskConnections) {
      final task = await _taskRepository.getTaskById(conn.toNodeId);
      if (task == null || !task.isCompleted) {
        return false;
      }
    }

    // All tasks are complete
    return true;
  }

  /// Update goal completion status based on auto-completion logic
  /// Returns true if the goal was updated
  Future<bool> updateGoalCompletion(Goal goal) async {
    final shouldComplete = await shouldAutoComplete(goal);

    // Only update if auto-complete is enabled and status needs to change
    if (goal.autoCompleteEnabled && shouldComplete && !goal.isManuallyCompleted) {
      final updatedGoal = goal.copyWith(
        isManuallyCompleted: true,
        updatedAt: DateTime.now(),
      );
      await _goalRepository.updateGoal(updatedGoal);
      return true;
    }

    // Check if goal should be uncompleted (if tasks became incomplete)
    if (goal.autoCompleteEnabled && !shouldComplete && goal.isManuallyCompleted) {
      final updatedGoal = goal.copyWith(
        isManuallyCompleted: false,
        updatedAt: DateTime.now(),
      );
      await _goalRepository.updateGoal(updatedGoal);
      return true;
    }

    return false;
  }

  /// Check and update all goals connected to a specific task
  /// Call this after updating a task's completion status
  Future<List<String>> updateGoalsForTask(String taskId) async {
    final updatedGoalIds = <String>[];

    // Get all connections to this task
    final connections = await _connectionRepository.getConnectionsToNode(taskId);
    final goalConnections = connections
        .where((c) => c.relationshipType == RelationshipType.goalToTask)
        .toList();

    // Update each connected goal
    for (final conn in goalConnections) {
      final goal = await _goalRepository.getGoalById(conn.fromNodeId);
      if (goal != null) {
        final wasUpdated = await updateGoalCompletion(goal);
        if (wasUpdated) {
          updatedGoalIds.add(goal.id);
        }
      }
    }

    return updatedGoalIds;
  }

  /// Calculate progress for a goal (0.0 to 1.0)
  Future<double> calculateProgress(Goal goal) async {
    if (!goal.autoCompleteEnabled) {
      return goal.isManuallyCompleted ? 1.0 : 0.0;
    }

    final connections = await _connectionRepository.getConnectionsFromNode(goal.id);
    final taskConnections = connections
        .where((c) => c.relationshipType == RelationshipType.goalToTask)
        .toList();

    if (taskConnections.isEmpty) {
      return 0.0;
    }

    var completedCount = 0;
    for (final conn in taskConnections) {
      final task = await _taskRepository.getTaskById(conn.toNodeId);
      if (task != null && task.isCompleted) {
        completedCount++;
      }
    }

    return completedCount / taskConnections.length;
  }

  /// Get completion summary for a goal
  Future<GoalCompletionSummary> getCompletionSummary(Goal goal) async {
    final connections = await _connectionRepository.getConnectionsFromNode(goal.id);
    final taskConnections = connections
        .where((c) => c.relationshipType == RelationshipType.goalToTask)
        .toList();

    var totalTasks = taskConnections.length;
    var completedTasks = 0;

    for (final conn in taskConnections) {
      final task = await _taskRepository.getTaskById(conn.toNodeId);
      if (task != null && task.isCompleted) {
        completedTasks++;
      }
    }

    final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    final isComplete = await shouldAutoComplete(goal);

    return GoalCompletionSummary(
      goalId: goal.id,
      totalTasks: totalTasks,
      completedTasks: completedTasks,
      progress: progress,
      isComplete: isComplete,
      autoCompleteEnabled: goal.autoCompleteEnabled,
      isManuallyCompleted: goal.isManuallyCompleted,
    );
  }
}

/// Summary of goal completion status
class GoalCompletionSummary {
  final String goalId;
  final int totalTasks;
  final int completedTasks;
  final double progress;
  final bool isComplete;
  final bool autoCompleteEnabled;
  final bool isManuallyCompleted;

  GoalCompletionSummary({
    required this.goalId,
    required this.totalTasks,
    required this.completedTasks,
    required this.progress,
    required this.isComplete,
    required this.autoCompleteEnabled,
    required this.isManuallyCompleted,
  });
}
