import 'package:flutter/material.dart';
import '../../domain/models/list.dart';
import '../../domain/models/list_item.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/list_item_repository_impl.dart';
import 'list_form_screen.dart';
import 'list_item_form_screen.dart';

class ListDetailScreen extends StatefulWidget {
  final ProgressList list;

  const ListDetailScreen({
    super.key,
    required this.list,
  });

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  List<ListItem> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() {
      _isLoading = true;
    });

    final database = db.AppDatabase();
    final repository = ListItemRepositoryImpl(database);

    try {
      final items = await repository.getListItemsByListId(widget.list.id);
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading items: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  Future<void> _navigateToItemForm({ListItem? item}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListItemFormScreen(
          listId: widget.list.id,
          item: item,
        ),
      ),
    );

    if (result == true) {
      _loadItems();
    }
  }

  Future<void> _navigateToListForm() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListFormScreen(list: widget.list),
      ),
    );

    if (result == true) {
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<void> _toggleItemCompletion(ListItem item) async {
    final database = db.AppDatabase();
    final repository = ListItemRepositoryImpl(database);

    try {
      final updatedItem = item.copyWith(
        isCompleted: !item.isCompleted,
        updatedAt: DateTime.now(),
      );
      await repository.updateListItem(updatedItem);
      _loadItems();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating item: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  Future<void> _deleteItem(ListItem item) async {
    final database = db.AppDatabase();
    final repository = ListItemRepositoryImpl(database);

    try {
      await repository.deleteListItem(item.id);
      _loadItems();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item deleted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting item: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _items.where((item) => item.isCompleted).length;
    final totalCount = _items.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToListForm,
          ),
        ],
      ),
      body: Column(
        children: [
          if (widget.list.description != null && widget.list.description!.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.list.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (widget.list.type != null && widget.list.type!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(widget.list.type!),
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ],
                ],
              ),
            ),
          if (totalCount > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                '$completedCount of $totalCount completed',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _items.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.list_outlined,
                              size: 64,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No items yet',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap the + button to add your first item',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return Dismissible(
                            key: Key(item.id),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Item'),
                                    content: Text(
                                      'Are you sure you want to delete "${item.title}"?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) {
                              _deleteItem(item);
                            },
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  item.isCompleted
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  color: item.isCompleted ? Colors.green : null,
                                ),
                                onPressed: () => _toggleItemCompletion(item),
                              ),
                              title: Text(
                                item.title,
                                style: item.isCompleted
                                    ? TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      )
                                    : null,
                              ),
                              subtitle: item.notes != null && item.notes!.isNotEmpty
                                  ? Text(item.notes!)
                                  : null,
                              onTap: () => _navigateToItemForm(item: item),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToItemForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
