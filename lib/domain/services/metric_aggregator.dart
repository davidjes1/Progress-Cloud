import '../models/metric_entry.dart';
import '../models/enums.dart';

/// Result of metric aggregation
class AggregationResult {
  final double value;
  final int entryCount;
  final DateTime startDate;
  final DateTime endDate;

  const AggregationResult({
    required this.value,
    required this.entryCount,
    required this.startDate,
    required this.endDate,
  });
}

/// Service for aggregating metric entries across different timeframes
class MetricAggregator {
  /// Aggregate metrics for a specific timeframe
  AggregationResult aggregateMetrics(
    List<MetricEntry> entries,
    AggregationType aggregationType,
    DateTime startDate,
    DateTime endDate,
  ) {
    // Filter entries within the date range
    final filteredEntries = entries.where((entry) {
      return entry.timestamp.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
          entry.timestamp.isBefore(endDate.add(const Duration(seconds: 1)));
    }).toList();

    if (filteredEntries.isEmpty) {
      return AggregationResult(
        value: 0.0,
        entryCount: 0,
        startDate: startDate,
        endDate: endDate,
      );
    }

    double aggregatedValue;
    switch (aggregationType) {
      case AggregationType.sum:
        aggregatedValue = _sum(filteredEntries);
        break;
      case AggregationType.average:
        aggregatedValue = _average(filteredEntries);
        break;
      case AggregationType.max:
        aggregatedValue = _max(filteredEntries);
        break;
      case AggregationType.min:
        aggregatedValue = _min(filteredEntries);
        break;
    }

    return AggregationResult(
      value: aggregatedValue,
      entryCount: filteredEntries.length,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Get date range for a specific timeframe relative to a reference date
  (DateTime, DateTime) getDateRangeForTimeframe(
    Timeframe timeframe,
    DateTime referenceDate,
  ) {
    DateTime startDate;
    DateTime endDate;

    switch (timeframe) {
      case Timeframe.daily:
        startDate = DateTime(
          referenceDate.year,
          referenceDate.month,
          referenceDate.day,
        );
        endDate = DateTime(
          referenceDate.year,
          referenceDate.month,
          referenceDate.day,
          23,
          59,
          59,
        );
        break;

      case Timeframe.weekly:
        // Week starts on Monday
        final weekday = referenceDate.weekday;
        startDate = referenceDate.subtract(Duration(days: weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        endDate = startDate.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
        break;

      case Timeframe.monthly:
        startDate = DateTime(referenceDate.year, referenceDate.month, 1);
        endDate = DateTime(
          referenceDate.year,
          referenceDate.month + 1,
          0,
          23,
          59,
          59,
        );
        break;

      case Timeframe.yearly:
        startDate = DateTime(referenceDate.year, 1, 1);
        endDate = DateTime(referenceDate.year, 12, 31, 23, 59, 59);
        break;
    }

    return (startDate, endDate);
  }

  /// Aggregate metrics for daily timeframe
  AggregationResult aggregateDaily(
    List<MetricEntry> entries,
    DateTime date,
    AggregationType aggregationType,
  ) {
    final (startDate, endDate) = getDateRangeForTimeframe(Timeframe.daily, date);
    return aggregateMetrics(entries, aggregationType, startDate, endDate);
  }

  /// Aggregate metrics for weekly timeframe
  AggregationResult aggregateWeekly(
    List<MetricEntry> entries,
    DateTime date,
    AggregationType aggregationType,
  ) {
    final (startDate, endDate) = getDateRangeForTimeframe(Timeframe.weekly, date);
    return aggregateMetrics(entries, aggregationType, startDate, endDate);
  }

  /// Aggregate metrics for monthly timeframe
  AggregationResult aggregateMonthly(
    List<MetricEntry> entries,
    DateTime date,
    AggregationType aggregationType,
  ) {
    final (startDate, endDate) = getDateRangeForTimeframe(Timeframe.monthly, date);
    return aggregateMetrics(entries, aggregationType, startDate, endDate);
  }

  /// Aggregate metrics for yearly timeframe
  AggregationResult aggregateYearly(
    List<MetricEntry> entries,
    DateTime date,
    AggregationType aggregationType,
  ) {
    final (startDate, endDate) = getDateRangeForTimeframe(Timeframe.yearly, date);
    return aggregateMetrics(entries, aggregationType, startDate, endDate);
  }

  // Private aggregation methods
  double _sum(List<MetricEntry> entries) {
    return entries.fold(0.0, (sum, entry) => sum + entry.metricValue);
  }

  double _average(List<MetricEntry> entries) {
    if (entries.isEmpty) return 0.0;
    return _sum(entries) / entries.length;
  }

  double _max(List<MetricEntry> entries) {
    if (entries.isEmpty) return 0.0;
    return entries.map((e) => e.metricValue).reduce((a, b) => a > b ? a : b);
  }

  double _min(List<MetricEntry> entries) {
    if (entries.isEmpty) return 0.0;
    return entries.map((e) => e.metricValue).reduce((a, b) => a < b ? a : b);
  }
}
