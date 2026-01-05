import '../models/goal.dart';

/// Repository interface for Goal data access
abstract class GoalRepository {
  /// Get all goals
  Future<List<Goal>> getAllGoals();

  /// Get a goal by ID
  Future<Goal?> getGoalById(String id);

  /// Create a new goal
  Future<void> createGoal(Goal goal);

  /// Update an existing goal
  Future<void> updateGoal(Goal goal);

  /// Delete a goal
  Future<void> deleteGoal(String id);

  /// Watch all goals (stream)
  Stream<List<Goal>> watchAllGoals();

  /// Watch a specific goal (stream)
  Stream<Goal?> watchGoal(String id);
}
