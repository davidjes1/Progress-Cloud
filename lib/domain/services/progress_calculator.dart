import '../models/task.dart';
import '../models/goal.dart';
import '../models/metric_entry.dart';
import '../models/enums.dart';
import 'metric_aggregator.dart';

/// Progress information for a task or goal
class ProgressInfo {
  final double currentValue;
  final double targetValue;
  final double percentage;
  final int completionCount;
  final bool isCompleted;

  const ProgressInfo({
    required this.currentValue,
    required this.targetValue,
    required this.percentage,
    this.completionCount = 0,
    this.isCompleted = false,
  });

  ProgressInfo copyWith({
    double? currentValue,
    double? targetValue,
    double? percentage,
    int? completionCount,
    bool? isCompleted,
  }) {
    return ProgressInfo(
      currentValue: currentValue ?? this.currentValue,
      targetValue: targetValue ?? this.targetValue,
      percentage: percentage ?? this.percentage,
      completionCount: completionCount ?? this.completionCount,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// Service for calculating progress on tasks and goals
class ProgressCalculator {
  final MetricAggregator _metricAggregator;

  ProgressCalculator({MetricAggregator? metricAggregator})
      : _metricAggregator = metricAggregator ?? MetricAggregator();

  /// Calculate progress for a metric-based task
  ProgressInfo calculateTaskProgress(
    Task task,
    List<MetricEntry> entries, {
    DateTime? referenceDate,
    AggregationType aggregationType = AggregationType.sum,
  }) {
    final date = referenceDate ?? DateTime.now();

    switch (task.completionRuleType) {
      case CompletionRuleType.boolean:
        return ProgressInfo(
          currentValue: task.isCompleted ? 1.0 : 0.0,
          targetValue: 1.0,
          percentage: task.isCompleted ? 100.0 : 0.0,
          isCompleted: task.isCompleted,
        );

      case CompletionRuleType.metricBased:
        if (task.metricTarget == null) {
          return const ProgressInfo(
            currentValue: 0.0,
            targetValue: 0.0,
            percentage: 0.0,
          );
        }

        final aggregationResult = _aggregateByTimeframe(
          entries,
          task.timeframe,
          date,
          aggregationType,
        );

        final percentage = (aggregationResult.value / task.metricTarget!) * 100;

        return ProgressInfo(
          currentValue: aggregationResult.value,
          targetValue: task.metricTarget!,
          percentage: percentage,
          completionCount: aggregationResult.entryCount,
          isCompleted: aggregationResult.value >= task.metricTarget!,
        );

      case CompletionRuleType.countBased:
        final aggregationResult = _aggregateByTimeframe(
          entries,
          task.timeframe,
          date,
          AggregationType.sum,
        );

        final target = task.metricTarget ?? 1.0;
        final percentage = (aggregationResult.entryCount / target) * 100;

        return ProgressInfo(
          currentValue: aggregationResult.entryCount.toDouble(),
          targetValue: target,
          percentage: percentage,
          completionCount: aggregationResult.entryCount,
          isCompleted: aggregationResult.entryCount >= target,
        );

      case CompletionRuleType.streak:
        // Streak calculation would require more complex logic
        // For now, return basic info
        return ProgressInfo(
          currentValue: entries.length.toDouble(),
          targetValue: task.metricTarget ?? 1.0,
          percentage: 0.0,
          completionCount: entries.length,
        );
    }
  }

  /// Calculate progress for a goal based on connected tasks
  ProgressInfo calculateGoalProgress(
    Goal goal,
    List<Task> connectedTasks,
    Map<String, List<MetricEntry>> taskMetrics, {
    DateTime? referenceDate,
  }) {
    if (connectedTasks.isEmpty) {
      return const ProgressInfo(
        currentValue: 0.0,
        targetValue: 0.0,
        percentage: 0.0,
      );
    }

    // If goal has a metric target, aggregate from tasks
    if (goal.metricTarget != null && goal.metricType != null) {
      double totalCurrent = 0.0;
      int totalEntries = 0;

      for (final task in connectedTasks) {
        final entries = taskMetrics[task.id] ?? [];
        final progress = calculateTaskProgress(
          task,
          entries,
          referenceDate: referenceDate,
        );
        totalCurrent += progress.currentValue;
        totalEntries += progress.completionCount;
      }

      final percentage = (totalCurrent / goal.metricTarget!) * 100;

      return ProgressInfo(
        currentValue: totalCurrent,
        targetValue: goal.metricTarget!,
        percentage: percentage,
        completionCount: totalEntries,
        isCompleted: totalCurrent >= goal.metricTarget!,
      );
    }

    // Otherwise, calculate based on task completion
    int completedTasks = 0;
    for (final task in connectedTasks) {
      final entries = taskMetrics[task.id] ?? [];
      final progress = calculateTaskProgress(task, entries, referenceDate: referenceDate);
      if (progress.isCompleted) {
        completedTasks++;
      }
    }

    final percentage = (completedTasks / connectedTasks.length) * 100;

    return ProgressInfo(
      currentValue: completedTasks.toDouble(),
      targetValue: connectedTasks.length.toDouble(),
      percentage: percentage,
      completionCount: completedTasks,
      isCompleted: completedTasks == connectedTasks.length,
    );
  }

  // Private helper methods
  AggregationResult _aggregateByTimeframe(
    List<MetricEntry> entries,
    Timeframe timeframe,
    DateTime date,
    AggregationType aggregationType,
  ) {
    switch (timeframe) {
      case Timeframe.daily:
        return _metricAggregator.aggregateDaily(entries, date, aggregationType);
      case Timeframe.weekly:
        return _metricAggregator.aggregateWeekly(entries, date, aggregationType);
      case Timeframe.monthly:
        return _metricAggregator.aggregateMonthly(entries, date, aggregationType);
      case Timeframe.yearly:
        return _metricAggregator.aggregateYearly(entries, date, aggregationType);
    }
  }
}
