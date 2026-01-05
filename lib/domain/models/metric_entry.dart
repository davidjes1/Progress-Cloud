import 'package:equatable/equatable.dart';

/// Metric entry model for tracking quantitative progress data
class MetricEntry extends Equatable {
  final String id;
  final String taskId;
  final DateTime timestamp;
  final double metricValue;
  final String metricUnit;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MetricEntry({
    required this.id,
    required this.taskId,
    required this.timestamp,
    required this.metricValue,
    required this.metricUnit,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  MetricEntry copyWith({
    String? id,
    String? taskId,
    DateTime? timestamp,
    double? metricValue,
    String? metricUnit,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MetricEntry(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      timestamp: timestamp ?? this.timestamp,
      metricValue: metricValue ?? this.metricValue,
      metricUnit: metricUnit ?? this.metricUnit,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        taskId,
        timestamp,
        metricValue,
        metricUnit,
        notes,
        createdAt,
        updatedAt,
      ];
}
