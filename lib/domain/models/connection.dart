import 'package:equatable/equatable.dart';
import 'enums.dart';

/// Connection model defining relationships between nodes
class Connection extends Equatable {
  final String id;
  final String fromNodeId;
  final String toNodeId;
  final RelationshipType relationshipType;
  final String? direction; // optional visual direction hint
  final DateTime createdAt;
  final DateTime updatedAt;

  const Connection({
    required this.id,
    required this.fromNodeId,
    required this.toNodeId,
    required this.relationshipType,
    this.direction,
    required this.createdAt,
    required this.updatedAt,
  });

  Connection copyWith({
    String? id,
    String? fromNodeId,
    String? toNodeId,
    RelationshipType? relationshipType,
    String? direction,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Connection(
      id: id ?? this.id,
      fromNodeId: fromNodeId ?? this.fromNodeId,
      toNodeId: toNodeId ?? this.toNodeId,
      relationshipType: relationshipType ?? this.relationshipType,
      direction: direction ?? this.direction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fromNodeId,
        toNodeId,
        relationshipType,
        direction,
        createdAt,
        updatedAt,
      ];
}
