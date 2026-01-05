import 'package:equatable/equatable.dart';

/// List model representing content collections
class ProgressList extends Equatable {
  final String id;
  final String name;
  final String? type; // e.g., "movies", "restaurants", "books", or custom
  final String? description;
  final double positionX;
  final double positionY;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProgressList({
    required this.id,
    required this.name,
    this.type,
    this.description,
    this.positionX = 0.0,
    this.positionY = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  ProgressList copyWith({
    String? id,
    String? name,
    String? type,
    String? description,
    double? positionX,
    double? positionY,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProgressList(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
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
        type,
        description,
        positionX,
        positionY,
        createdAt,
        updatedAt,
      ];
}
