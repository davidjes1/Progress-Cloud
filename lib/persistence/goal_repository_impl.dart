import 'package:drift/drift.dart';
import '../domain/models/goal.dart' as model;
import '../domain/models/enums.dart';
import '../domain/repositories/goal_repository.dart';
import 'database.dart' as db;

class GoalRepositoryImpl implements GoalRepository {
  final db.AppDatabase _db;

  GoalRepositoryImpl(this._db);

  @override
  Future<List<model.Goal>> getAllGoals() async {
    final goals = await _db.select(_db.goals).get();
    return goals.map(_goalFromDb).toList();
  }

  @override
  Future<model.Goal?> getGoalById(String id) async {
    final goal = await (_db.select(_db.goals)
          ..where((g) => g.id.equals(id)))
        .getSingleOrNull();
    return goal != null ? _goalFromDb(goal) : null;
  }

  @override
  Future<void> createGoal(model.Goal goal) async {
    await _db.into(_db.goals).insert(
          db.GoalsCompanion.insert(
            id: goal.id,
            name: goal.name,
            description: Value(goal.description),
            timeframe: Value(goal.timeframe?.index),
            metricType: Value(goal.metricType?.index),
            metricUnit: Value(goal.metricUnit),
            metricTarget: Value(goal.metricTarget),
            isManuallyCompleted: Value(goal.isManuallyCompleted),
            autoCompleteEnabled: Value(goal.autoCompleteEnabled),
            positionX: Value(goal.positionX),
            positionY: Value(goal.positionY),
            createdAt: goal.createdAt,
            updatedAt: goal.updatedAt,
          ),
        );
  }

  @override
  Future<void> updateGoal(model.Goal goal) async {
    await (_db.update(_db.goals)..where((g) => g.id.equals(goal.id))).write(
      db.GoalsCompanion(
        name: Value(goal.name),
        description: Value(goal.description),
        timeframe: Value(goal.timeframe?.index),
        metricType: Value(goal.metricType?.index),
        metricUnit: Value(goal.metricUnit),
        metricTarget: Value(goal.metricTarget),
        isManuallyCompleted: Value(goal.isManuallyCompleted),
        autoCompleteEnabled: Value(goal.autoCompleteEnabled),
        positionX: Value(goal.positionX),
        positionY: Value(goal.positionY),
        updatedAt: Value(goal.updatedAt),
      ),
    );
  }

  @override
  Future<void> deleteGoal(String id) async {
    await (_db.delete(_db.goals)..where((g) => g.id.equals(id))).go();
  }

  @override
  Stream<List<model.Goal>> watchAllGoals() {
    return _db.select(_db.goals).watch().map((goals) {
      return goals.map(_goalFromDb).toList();
    });
  }

  @override
  Stream<model.Goal?> watchGoal(String id) {
    return (_db.select(_db.goals)..where((g) => g.id.equals(id)))
        .watchSingleOrNull()
        .map((goal) => goal != null ? _goalFromDb(goal) : null);
  }

  model.Goal _goalFromDb(db.GoalData dbGoal) {
    return model.Goal(
      id: dbGoal.id,
      name: dbGoal.name,
      description: dbGoal.description,
      timeframe: dbGoal.timeframe != null ? Timeframe.values[dbGoal.timeframe!] : null,
      metricType: dbGoal.metricType != null ? MetricType.values[dbGoal.metricType!] : null,
      metricUnit: dbGoal.metricUnit,
      metricTarget: dbGoal.metricTarget,
      isManuallyCompleted: dbGoal.isManuallyCompleted,
      autoCompleteEnabled: dbGoal.autoCompleteEnabled,
      positionX: dbGoal.positionX,
      positionY: dbGoal.positionY,
      createdAt: dbGoal.createdAt,
      updatedAt: dbGoal.updatedAt,
    );
  }
}
