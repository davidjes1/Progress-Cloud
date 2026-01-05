import '../models/metric_entry.dart';

/// Repository interface for MetricEntry data access
abstract class MetricEntryRepository {
  /// Get all metric entries
  Future<List<MetricEntry>> getAllMetricEntries();

  /// Get a metric entry by ID
  Future<MetricEntry?> getMetricEntryById(String id);

  /// Get all metric entries for a specific task
  Future<List<MetricEntry>> getEntriesByTaskId(String taskId);

  /// Get metric entries for a task within a date range
  Future<List<MetricEntry>> getEntriesByTaskIdAndDateRange(
    String taskId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Create a new metric entry
  Future<void> createMetricEntry(MetricEntry entry);

  /// Update an existing metric entry
  Future<void> updateMetricEntry(MetricEntry entry);

  /// Delete a metric entry
  Future<void> deleteMetricEntry(String id);

  /// Watch all metric entries for a task (stream)
  Stream<List<MetricEntry>> watchMetricEntriesForTask(String taskId);

  /// Watch metric entries for a task within a date range (stream)
  Stream<List<MetricEntry>> watchMetricEntriesByDateRange(
    String taskId,
    DateTime startDate,
    DateTime endDate,
  );
}
