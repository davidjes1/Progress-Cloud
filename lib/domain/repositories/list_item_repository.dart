import '../models/list_item.dart';

/// Repository interface for ListItem data access
abstract class ListItemRepository {
  /// Get all list items
  Future<List<ListItem>> getAllListItems();

  /// Get a list item by ID
  Future<ListItem?> getListItemById(String id);

  /// Get all items for a specific list
  Future<List<ListItem>> getListItemsByListId(String listId);

  /// Create a new list item
  Future<void> createListItem(ListItem item);

  /// Update an existing list item
  Future<void> updateListItem(ListItem item);

  /// Delete a list item
  Future<void> deleteListItem(String id);

  /// Watch all list items (stream)
  Stream<List<ListItem>> watchAllListItems();

  /// Watch items for a specific list (stream)
  Stream<List<ListItem>> watchListItemsByListId(String listId);
}
