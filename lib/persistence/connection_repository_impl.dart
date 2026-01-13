import 'package:drift/drift.dart';
import '../domain/models/connection.dart' as model;
import '../domain/models/enums.dart';
import '../domain/repositories/connection_repository.dart';
import 'database.dart' as db;

class ConnectionRepositoryImpl implements ConnectionRepository {
  final db.AppDatabase _db;

  ConnectionRepositoryImpl(this._db);

  @override
  Future<List<model.Connection>> getAllConnections() async {
    final connections = await _db.select(_db.connections).get();
    return connections.map((c) => _connectionFromDb(c)).toList();
  }

  @override
  Future<model.Connection?> getConnectionById(String id) async {
    final connection = await (_db.select(_db.connections)
          ..where((c) => c.id.equals(id)))
        .getSingleOrNull();
    return connection != null ? _connectionFromDb(connection) : null;
  }

  @override
  Future<List<model.Connection>> getConnectionsFromNode(String nodeId) async {
    final connections = await (_db.select(_db.connections)
          ..where((c) => c.fromNodeId.equals(nodeId)))
        .get();
    return connections.map((c) => _connectionFromDb(c)).toList();
  }

  @override
  Future<List<model.Connection>> getConnectionsToNode(String nodeId) async {
    final connections = await (_db.select(_db.connections)
          ..where((c) => c.toNodeId.equals(nodeId)))
        .get();
    return connections.map((c) => _connectionFromDb(c)).toList();
  }

  @override
  Future<List<model.Connection>> getConnectionsForNode(String nodeId) async {
    final connections = await (_db.select(_db.connections)
          ..where((c) =>
              c.fromNodeId.equals(nodeId) | c.toNodeId.equals(nodeId)))
        .get();
    return connections.map((c) => _connectionFromDb(c)).toList();
  }

  @override
  Future<void> createConnection(model.Connection connection) async {
    await _db.into(_db.connections).insert(
          db.ConnectionsCompanion.insert(
            id: connection.id,
            fromNodeId: connection.fromNodeId,
            toNodeId: connection.toNodeId,
            relationshipType: connection.relationshipType.index,
            direction: Value(connection.direction),
            createdAt: connection.createdAt,
            updatedAt: connection.updatedAt,
          ),
        );
  }

  @override
  Future<void> updateConnection(model.Connection connection) async {
    await (_db.update(_db.connections)
          ..where((c) => c.id.equals(connection.id)))
        .write(
      db.ConnectionsCompanion(
        fromNodeId: Value(connection.fromNodeId),
        toNodeId: Value(connection.toNodeId),
        relationshipType: Value(connection.relationshipType.index),
        direction: Value(connection.direction),
        updatedAt: Value(connection.updatedAt),
      ),
    );
  }

  @override
  Future<void> deleteConnection(String id) async {
    await (_db.delete(_db.connections)..where((c) => c.id.equals(id))).go();
  }

  @override
  Stream<List<model.Connection>> watchAllConnections() {
    return _db.select(_db.connections).watch().map((connections) {
      return connections.map((c) => _connectionFromDb(c)).toList();
    });
  }

  @override
  Stream<List<model.Connection>> watchConnectionsForNode(String nodeId) {
    return (_db.select(_db.connections)
          ..where((c) =>
              c.fromNodeId.equals(nodeId) | c.toNodeId.equals(nodeId)))
        .watch()
        .map((connections) {
      return connections.map((c) => _connectionFromDb(c)).toList();
    });
  }

  model.Connection _connectionFromDb(db.ConnectionData dbConnection) {
    return model.Connection(
      id: dbConnection.id,
      fromNodeId: dbConnection.fromNodeId,
      toNodeId: dbConnection.toNodeId,
      relationshipType: RelationshipType.values[dbConnection.relationshipType],
      direction: dbConnection.direction,
      createdAt: dbConnection.createdAt,
      updatedAt: dbConnection.updatedAt,
    );
  }
}
