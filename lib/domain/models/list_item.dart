import 'package:equatable/equatable.dart';

/// List item model representing actionable or consumable entries
class ListItem extends Equatable {
  final String id;
  final String listId;
  final String title;
  final String? notes;
  final Map<String, dynamic> metadata; // rating, location, etc.
  final bool isCompleted;
  final double positionX;
  final double positionY;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ListItem({
    required this.id,
    required this.listId,
    required this.title,
    this.notes,
    this.metadata = const {},
    this.isCompleted = false,
    this.positionX = 0.0,
    this.positionY = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  ListItem copyWith({
    String? id,
    String? listId,
    String? title,
    String? notes,
    Map<String, dynamic>? metadata,
    bool? isCompleted,
    double? positionX,
    double? positionY,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ListItem(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      metadata: metadata ?? this.metadata,
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
        listId,
        title,
        notes,
        metadata,
        isCompleted,
        positionX,
        positionY,
        createdAt,
        updatedAt,
      ];
}
