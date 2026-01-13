import 'package:drift/drift.dart';

// Conditional imports for platform-specific database implementations
import 'database_connection_stub.dart'
    if (dart.library.io) 'database_connection_native.dart'
    if (dart.library.html) 'database_connection_web.dart';

part 'database.g.dart';

// Tasks table
@DataClassName('TaskData')
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
@DataClassName('GoalData')
class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get timeframe => integer().nullable()(); // Timeframe enum index
  IntColumn get metricType => integer().nullable()(); // MetricType enum index
  TextColumn get metricUnit => text().nullable()();
  RealColumn get metricTarget => real().nullable()();
  BoolColumn get isManuallyCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get autoCompleteEnabled => boolean().withDefault(const Constant(true))();
  RealColumn get positionX => real().withDefault(const Constant(0.0))();
  RealColumn get positionY => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Lists table
@DataClassName('ProgressListData')
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
@DataClassName('ListItemData')
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
@DataClassName('ConnectionData')
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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          // Migration from schema v1 to v2: Add completion fields to Goals table
          await migrator.addColumn(goals, goals.isManuallyCompleted);
          await migrator.addColumn(goals, goals.autoCompleteEnabled);
        }
      },
    );
  }

  static QueryExecutor _openConnection() {
    return openConnection('progress_cloud');
  }
}
