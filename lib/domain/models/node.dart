import 'package:equatable/equatable.dart';
import 'enums.dart';

/// Base node class for all visualizable elements in the graph
class Node extends Equatable {
  final String id;
  final NodeType nodeType;
  final String title;
  final Map<String, dynamic> metadata;
  final double positionX;
  final double positionY;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Node({
    required this.id,
    required this.nodeType,
    required this.title,
    this.metadata = const {},
    this.positionX = 0.0,
    this.positionY = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  Node copyWith({
    String? id,
    NodeType? nodeType,
    String? title,
    Map<String, dynamic>? metadata,
    double? positionX,
    double? positionY,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Node(
      id: id ?? this.id,
      nodeType: nodeType ?? this.nodeType,
      title: title ?? this.title,
      metadata: metadata ?? this.metadata,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        nodeType,
        title,
        metadata,
        positionX,
        positionY,
        createdAt,
        updatedAt,
      ];
}
