import 'package:flutter/material.dart';
import '../../domain/models/list.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/list_repository_impl.dart';
import '../../persistence/list_item_repository_impl.dart';
import 'list_form_screen.dart';
import 'list_detail_screen.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  List<ProgressList> _lists = [];
  Map<String, int> _totalCounts = {};
  Map<String, int> _completedCounts = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLists();
  }

  Future<void> _loadLists() async {
    setState(() => _isLoading = true);

    final database = db.AppDatabase();
    final listRepo = ListRepositoryImpl(database);
    final itemRepo = ListItemRepositoryImpl(database);

    try {
      final lists = await listRepo.getAllLists();
      final totals = <String, int>{};
      final completed = <String, int>{};

      for (final list in lists) {
        final items = await itemRepo.getListItemsByListId(list.id);
        totals[list.id] = items.length;
        completed[list.id] = items.where((i) => i.isCompleted).length;
      }

      setState(() {
        _lists = lists;
        _totalCounts = totals;
        _completedCounts = completed;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading collections: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  Future<void> _navigateToForm({ProgressList? list}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListFormScreen(list: list),
      ),
    );
    if (result == true) _loadLists();
  }

  Future<void> _navigateToDetail(ProgressList list) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListDetailScreen(list: list),
      ),
    );
    if (result == true) _loadLists();
  }

  Future<void> _deleteList(ProgressList list) async {
    final database = db.AppDatabase();
    final listRepo = ListRepositoryImpl(database);
    final itemRepo = ListItemRepositoryImpl(database);

    try {
      // Delete all items first
      final items = await itemRepo.getListItemsByListId(list.id);
      for (final item in items) {
        await itemRepo.deleteListItem(item.id);
      }
      await listRepo.deleteList(list.id);
      _loadLists();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting collection: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  IconData _listIcon(ProgressList list) {
    final type = list.type?.toLowerCase() ?? '';
    if (type.contains('movie') || type.contains('film')) {
      return Icons.movie_outlined;
    } else if (type.contains('book') || type.contains('read')) {
      return Icons.menu_book_outlined;
    } else if (type.contains('travel') ||
        type.contains('place') ||
        type.contains('restaurant')) {
      return Icons.place_outlined;
    } else if (type.contains('music') || type.contains('album')) {
      return Icons.music_note_outlined;
    }
    return Icons.checklist_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        centerTitle: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _lists.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: _loadLists,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    itemCount: _lists.length,
                    itemBuilder: (context, index) {
                      return _buildListCard(_lists[index]);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Collection'),
      ),
    );
  }

  Widget _buildListCard(ProgressList list) {
    final total = _totalCounts[list.id] ?? 0;
    final done = _completedCounts[list.id] ?? 0;
    final progress = total > 0 ? done / total : 0.0;
    final isComplete = total > 0 && done == total;
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: Key(list.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 28),
            SizedBox(height: 4),
            Text('Delete', style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Collection'),
            content: Text(
                'Delete "${list.name}" and all its items?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => _deleteList(list),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: isComplete ? 0 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isComplete
              ? BorderSide(color: Colors.green.shade300, width: 1.5)
              : BorderSide.none,
        ),
        color: isComplete
            ? Colors.green.withOpacity(0.05)
            : colorScheme.surface,
        child: InkWell(
          onTap: () => _navigateToDetail(list),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isComplete
                        ? Colors.green.withOpacity(0.15)
                        : colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isComplete ? Icons.check_circle_outline : _listIcon(list),
                    color: isComplete
                        ? Colors.green
                        : colorScheme.onPrimaryContainer,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              list.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    decoration: isComplete
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: isComplete
                                        ? colorScheme.onSurfaceVariant
                                        : colorScheme.onSurface,
                                  ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 16),
                            onPressed: () => _navigateToForm(list: list),
                            color: colorScheme.onSurfaceVariant,
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                      if (list.type != null && list.type!.isNotEmpty)
                        Text(
                          list.type!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      if (total > 0) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 4,
                                borderRadius: BorderRadius.circular(2),
                                backgroundColor:
                                    colorScheme.surfaceContainerHighest,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isComplete
                                      ? Colors.green
                                      : colorScheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$done/$total',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ] else
                        Text(
                          'No items yet',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.collections_bookmark_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            ),
            const SizedBox(height: 24),
            Text(
              'No collections yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Create collections for movies to watch, places to visit, books to read, and more.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => _navigateToForm(),
              icon: const Icon(Icons.add),
              label: const Text('New Collection'),
            ),
          ],
        ),
      ),
    );
  }
}
