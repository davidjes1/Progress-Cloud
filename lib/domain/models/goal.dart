import 'package:equatable/equatable.dart';
import 'enums.dart';

/// Goal model representing higher-level intent
class Goal extends Equatable {
  final String id;
  final String name;
  final String? description;
  final Timeframe? timeframe;
  final MetricType? metricType;
  final String? metricUnit;
  final double? metricTarget;
  final double positionX;
  final double positionY;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Goal({
    required this.id,
    required this.name,
    this.description,
    this.timeframe,
    this.metricType,
    this.metricUnit,
    this.metricTarget,
    this.positionX = 0.0,
    this.positionY = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  Goal copyWith({
    String? id,
    String? name,
    String? description,
    Timeframe? timeframe,
    MetricType? metricType,
    String? metricUnit,
    double? metricTarget,
    double? positionX,
    double? positionY,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      timeframe: timeframe ?? this.timeframe,
      metricType: metricType ?? this.metricType,
      metricUnit: metricUnit ?? this.metricUnit,
      metricTarget: metricTarget ?? this.metricTarget,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        timeframe,
        metricType,
        metricUnit,
        metricTarget,
        positionX,
        positionY,
        createdAt,
        updatedAt,
      ];
}
