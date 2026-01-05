/// Node types for the graph visualization
enum NodeType {
  task,
  goal,
  list,
  listItem,
}

/// Timeframe options for tasks and goals
enum Timeframe {
  daily,
  weekly,
  monthly,
  yearly,
}

/// Types of metrics that can be tracked
enum MetricType {
  distance,
  time,
  count,
  custom,
  none,
}

/// Units for distance metrics
enum DistanceUnit {
  miles,
  kilometers,
  meters,
  feet,
}

/// Units for time metrics
enum TimeUnit {
  seconds,
  minutes,
  hours,
  days,
}

/// Types of metric aggregation
enum AggregationType {
  sum,
  average,
  max,
  min,
}

/// Relationship types between nodes
enum RelationshipType {
  goalToTask,
  taskToList,
  taskToListItem,
  goalToGoal,
  listToListItem,
}

/// Completion rule types for tasks
enum CompletionRuleType {
  boolean,
  countBased,
  metricBased,
  streak,
}
