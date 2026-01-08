import 'package:drift/drift.dart';
import '../domain/models/list.dart' as model;
import '../domain/repositories/list_repository.dart';
import 'database.dart' as db;

class ListRepositoryImpl implements ListRepository {
  final db.AppDatabase _db;

  ListRepositoryImpl(this._db);

  @override
  Future<List<model.ProgressList>> getAllLists() async {
    final lists = await _db.select(_db.lists).get();
    return lists.map(_listFromDb).toList();
  }

  @override
  Future<model.ProgressList?> getListById(String id) async {
    final list = await (_db.select(_db.lists)
          ..where((l) => l.id.equals(id)))
        .getSingleOrNull();
    return list != null ? _listFromDb(list) : null;
  }

  @override
  Future<void> createList(model.ProgressList list) async {
    await _db.into(_db.lists).insert(
          db.ListsCompanion.insert(
            id: list.id,
            name: list.name,
            type: Value(list.type),
            description: Value(list.description),
            positionX: Value(list.positionX),
            positionY: Value(list.positionY),
            createdAt: list.createdAt,
            updatedAt: list.updatedAt,
          ),
        );
  }

  @override
  Future<void> updateList(model.ProgressList list) async {
    await (_db.update(_db.lists)..where((l) => l.id.equals(list.id))).write(
      db.ListsCompanion(
        name: Value(list.name),
        type: Value(list.type),
        description: Value(list.description),
        positionX: Value(list.positionX),
        positionY: Value(list.positionY),
        updatedAt: Value(list.updatedAt),
      ),
    );
  }

  @override
  Future<void> deleteList(String id) async {
    await (_db.delete(_db.lists)..where((l) => l.id.equals(id))).go();
  }

  @override
  Stream<List<model.ProgressList>> watchAllLists() {
    return _db.select(_db.lists).watch().map((lists) {
      return lists.map(_listFromDb).toList();
    });
  }

  @override
  Stream<model.ProgressList?> watchList(String id) {
    return (_db.select(_db.lists)..where((l) => l.id.equals(id)))
        .watchSingleOrNull()
        .map((list) => list != null ? _listFromDb(list) : null);
  }

  model.ProgressList _listFromDb(db.ProgressListData dbList) {
    return model.ProgressList(
      id: dbList.id,
      name: dbList.name,
      type: dbList.type,
      description: dbList.description,
      positionX: dbList.positionX,
      positionY: dbList.positionY,
      createdAt: dbList.createdAt,
      updatedAt: dbList.updatedAt,
    );
  }
}
