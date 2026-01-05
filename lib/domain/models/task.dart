import 'package:equatable/equatable.dart';
import 'enums.dart';

/// Task model representing actionable units of work
class Task extends Equatable {
  final String id;
  final String title;
  final String? description;
  final Timeframe timeframe;
  final CompletionRuleType completionRuleType;
  final MetricType metricType;
  final String? metricUnit; // Flexible string for custom units
  final double? metricTarget; // Target value for metric-based tasks
  final bool isCompleted;
  final double positionX;
  final double positionY;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.timeframe,
    required this.completionRuleType,
    this.metricType = MetricType.none,
    this.metricUnit,
    this.metricTarget,
    this.isCompleted = false,
    this.positionX = 0.0,
    this.positionY = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    Timeframe? timeframe,
    CompletionRuleType? completionRuleType,
    MetricType? metricType,
    String? metricUnit,
    double? metricTarget,
    bool? isCompleted,
    double? positionX,
    double? positionY,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timeframe: timeframe ?? this.timeframe,
      completionRuleType: completionRuleType ?? this.completionRuleType,
      metricType: metricType ?? this.metricType,
      metricUnit: metricUnit ?? this.metricUnit,
      metricTarget: metricTarget ?? this.metricTarget,
      isCompleted: isCompleted ?? this.isCompleted,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        timeframe,
        completionRuleType,
        metricType,
        metricUnit,
        metricTarget,
        isCompleted,
        positionX,
        positionY,
        createdAt,
        updatedAt,
      ];
}
