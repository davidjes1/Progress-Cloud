import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Tasks table
class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get timeframe => integer()(); // Timeframe enum index
  IntColumn get completionRuleType => integer()(); // CompletionRuleType enum index
  IntColumn get metricType => integer()(); // MetricType enum index
  TextColumn get metricUnit => text().nullable()();
  RealColumn get metricTarget => real().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  RealColumn get positionX => real().withDefault(const Constant(0.0))();
  RealColumn get positionY => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Goals table
class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get timeframe => integer().nullable()(); // Timeframe enum index
  IntColumn get metricType => integer().nullable()(); // MetricType enum index
  TextColumn get metricUnit => text().nullable()();
  RealColumn get metricTarget => real().nullable()();
  RealColumn get positionX => real().withDefault(const Constant(0.0))();
  RealColumn get positionY => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Lists table
class Lists extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text().nullable()();
  TextColumn get description => text().nullable()();
  RealColumn get positionX => real().withDefault(const Constant(0.0))();
  RealColumn get positionY => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// ListItems table
class ListItems extends Table {
  TextColumn get id => text()();
  TextColumn get listId => text()();
  TextColumn get title => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get metadata => text().withDefault(const Constant('{}'))(); // JSON string
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  RealColumn get positionX => real().withDefault(const Constant(0.0))();
  RealColumn get positionY => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Connections table
class Connections extends Table {
  TextColumn get id => text()();
  TextColumn get fromNodeId => text()();
  TextColumn get toNodeId => text()();
  IntColumn get relationshipType => integer()(); // RelationshipType enum index
  TextColumn get direction => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// MetricEntries table
class MetricEntries extends Table {
  TextColumn get id => text()();
  TextColumn get taskId => text()();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get metricValue => real()();
  TextColumn get metricUnit => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Tasks, Goals, Lists, ListItems, Connections, MetricEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'progress_cloud.db'));
      return NativeDatabase(file);
    });
  }
}
