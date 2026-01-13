import 'dart:convert';
import 'package:drift/drift.dart';
import '../domain/models/list_item.dart' as model;
import '../domain/repositories/list_item_repository.dart';
import 'database.dart' as db;

class ListItemRepositoryImpl implements ListItemRepository {
  final db.AppDatabase _db;

  ListItemRepositoryImpl(this._db);

  @override
  Future<List<model.ListItem>> getAllListItems() async {
    final items = await _db.select(_db.listItems).get();
    return items.map((i) => _listItemFromDb(i)).toList();
  }

  @override
  Future<model.ListItem?> getListItemById(String id) async {
    final item = await (_db.select(_db.listItems)
          ..where((i) => i.id.equals(id)))
        .getSingleOrNull();
    return item != null ? _listItemFromDb(item) : null;
  }

  @override
  Future<List<model.ListItem>> getListItemsByListId(String listId) async {
    final items = await (_db.select(_db.listItems)
          ..where((i) => i.listId.equals(listId)))
        .get();
    return items.map((i) => _listItemFromDb(i)).toList();
  }

  @override
  Future<void> createListItem(model.ListItem item) async {
    await _db.into(_db.listItems).insert(
          db.ListItemsCompanion.insert(
            id: item.id,
            listId: item.listId,
            title: item.title,
            notes: Value(item.notes),
            metadata: Value(jsonEncode(item.metadata)),
            isCompleted: Value(item.isCompleted),
            positionX: Value(item.positionX),
            positionY: Value(item.positionY),
            createdAt: item.createdAt,
            updatedAt: item.updatedAt,
          ),
        );
  }

  @override
  Future<void> updateListItem(model.ListItem item) async {
    await (_db.update(_db.listItems)..where((i) => i.id.equals(item.id)))
        .write(
      db.ListItemsCompanion(
        listId: Value(item.listId),
        title: Value(item.title),
        notes: Value(item.notes),
        metadata: Value(jsonEncode(item.metadata)),
        isCompleted: Value(item.isCompleted),
        positionX: Value(item.positionX),
        positionY: Value(item.positionY),
        updatedAt: Value(item.updatedAt),
      ),
    );
  }

  @override
  Future<void> deleteListItem(String id) async {
    await (_db.delete(_db.listItems)..where((i) => i.id.equals(id))).go();
  }

  @override
  Stream<List<model.ListItem>> watchAllListItems() {
    return _db.select(_db.listItems).watch().map((items) {
      return items.map((i) => _listItemFromDb(i)).toList();
    });
  }

  @override
  Stream<List<model.ListItem>> watchListItemsByListId(String listId) {
    return (_db.select(_db.listItems)..where((i) => i.listId.equals(listId)))
        .watch()
        .map((items) {
      return items.map((i) => _listItemFromDb(i)).toList();
    });
  }

  model.ListItem _listItemFromDb(db.ListItemData dbItem) {
    return model.ListItem(
      id: dbItem.id,
      listId: dbItem.listId,
      title: dbItem.title,
      notes: dbItem.notes,
      metadata: jsonDecode(dbItem.metadata) as Map<String, dynamic>,
      isCompleted: dbItem.isCompleted,
      positionX: dbItem.positionX,
      positionY: dbItem.positionY,
      createdAt: dbItem.createdAt,
      updatedAt: dbItem.updatedAt,
    );
  }
}
