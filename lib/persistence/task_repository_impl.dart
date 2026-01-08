import 'package:drift/drift.dart';
import '../domain/models/task.dart' as model;
import '../domain/models/enums.dart';
import '../domain/repositories/task_repository.dart';
import 'database.dart' as db;

class TaskRepositoryImpl implements TaskRepository {
  final db.AppDatabase _db;

  TaskRepositoryImpl(this._db);

  @override
  Future<List<model.Task>> getAllTasks() async {
    final tasks = await _db.select(_db.tasks).get();
    return tasks.map(_taskFromDb).toList();
  }

  @override
  Future<model.Task?> getTaskById(String id) async {
    final task = await (_db.select(_db.tasks)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return task != null ? _taskFromDb(task) : null;
  }

  @override
  Future<void> createTask(model.Task task) async {
    await _db.into(_db.tasks).insert(
          db.TasksCompanion.insert(
            id: task.id,
            title: task.title,
            description: Value(task.description),
            timeframe: task.timeframe.index,
            completionRuleType: task.completionRuleType.index,
            metricType: task.metricType.index,
            metricUnit: Value(task.metricUnit),
            metricTarget: Value(task.metricTarget),
            isCompleted: Value(task.isCompleted),
            positionX: Value(task.positionX),
            positionY: Value(task.positionY),
            createdAt: task.createdAt,
            updatedAt: task.updatedAt,
          ),
        );
  }

  @override
  Future<void> updateTask(model.Task task) async {
    await (_db.update(_db.tasks)..where((t) => t.id.equals(task.id))).write(
      db.TasksCompanion(
        title: Value(task.title),
        description: Value(task.description),
        timeframe: Value(task.timeframe.index),
        completionRuleType: Value(task.completionRuleType.index),
        metricType: Value(task.metricType.index),
        metricUnit: Value(task.metricUnit),
        metricTarget: Value(task.metricTarget),
        isCompleted: Value(task.isCompleted),
        positionX: Value(task.positionX),
        positionY: Value(task.positionY),
        updatedAt: Value(task.updatedAt),
      ),
    );
  }

  @override
  Future<void> deleteTask(String id) async {
    await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<model.Task>> getTasksByTimeframe(String timeframe) async {
    final timeframeEnum = Timeframe.values.firstWhere(
      (t) => t.name == timeframe,
      orElse: () => Timeframe.daily,
    );
    final tasks = await (_db.select(_db.tasks)
          ..where((t) => t.timeframe.equals(timeframeEnum.index)))
        .get();
    return tasks.map(_taskFromDb).toList();
  }

  @override
  Stream<List<model.Task>> watchAllTasks() {
    return _db.select(_db.tasks).watch().map((tasks) {
      return tasks.map(_taskFromDb).toList();
    });
  }

  @override
  Stream<model.Task?> watchTask(String id) {
    return (_db.select(_db.tasks)..where((t) => t.id.equals(id)))
        .watchSingleOrNull()
        .map((task) => task != null ? _taskFromDb(task) : null);
  }

  model.Task _taskFromDb(db.TaskData dbTask) {
    return model.Task(
      id: dbTask.id,
      title: dbTask.title,
      description: dbTask.description,
      timeframe: Timeframe.values[dbTask.timeframe],
      completionRuleType: CompletionRuleType.values[dbTask.completionRuleType],
      metricType: MetricType.values[dbTask.metricType],
      metricUnit: dbTask.metricUnit,
      metricTarget: dbTask.metricTarget,
      isCompleted: dbTask.isCompleted,
      positionX: dbTask.positionX,
      positionY: dbTask.positionY,
      createdAt: dbTask.createdAt,
      updatedAt: dbTask.updatedAt,
    );
  }
}
