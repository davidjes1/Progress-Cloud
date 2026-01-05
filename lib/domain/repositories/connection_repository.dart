import '../models/connection.dart';

/// Repository interface for Connection data access
abstract class ConnectionRepository {
  /// Get all connections
  Future<List<Connection>> getAllConnections();

  /// Get a connection by ID
  Future<Connection?> getConnectionById(String id);

  /// Get connections from a specific node
  Future<List<Connection>> getConnectionsFromNode(String nodeId);

  /// Get connections to a specific node
  Future<List<Connection>> getConnectionsToNode(String nodeId);

  /// Get all connections for a node (both from and to)
  Future<List<Connection>> getConnectionsForNode(String nodeId);

  /// Create a new connection
  Future<void> createConnection(Connection connection);

  /// Update an existing connection
  Future<void> updateConnection(Connection connection);

  /// Delete a connection
  Future<void> deleteConnection(String id);

  /// Watch all connections (stream)
  Stream<List<Connection>> watchAllConnections();

  /// Watch connections for a specific node (stream)
  Stream<List<Connection>> watchConnectionsForNode(String nodeId);
}
