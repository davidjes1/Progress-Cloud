import '../models/list.dart';
import '../models/list_item.dart';

/// Repository interface for List data access
abstract class ListRepository {
  /// Get all lists
  Future<List<ProgressList>> getAllLists();

  /// Get a list by ID
  Future<ProgressList?> getListById(String id);

  /// Create a new list
  Future<void> createList(ProgressList list);

  /// Update an existing list
  Future<void> updateList(ProgressList list);

  /// Delete a list
  Future<void> deleteList(String id);

  /// Watch all lists (stream)
  Stream<List<ProgressList>> watchAllLists();

  /// Watch a specific list (stream)
  Stream<ProgressList?> watchList(String id);
}

/// Repository interface for ListItem data access
abstract class ListItemRepository {
  /// Get all list items
  Future<List<ListItem>> getAllListItems();

  /// Get a list item by ID
  Future<ListItem?> getListItemById(String id);

  /// Get all items for a specific list
  Future<List<ListItem>> getItemsByListId(String listId);

  /// Create a new list item
  Future<void> createListItem(ListItem item);

  /// Update an existing list item
  Future<void> updateListItem(ListItem item);

  /// Delete a list item
  Future<void> deleteListItem(String id);

  /// Watch all list items (stream)
  Stream<List<ListItem>> watchAllListItems();

  /// Watch items for a specific list (stream)
  Stream<List<ListItem>> watchListItems(String listId);
}
