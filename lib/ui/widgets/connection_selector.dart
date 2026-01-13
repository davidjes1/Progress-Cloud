import 'package:flutter/material.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/task.dart';
import '../../domain/models/goal.dart';
import '../../domain/models/list.dart';
import '../../domain/models/list_item.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/task_repository_impl.dart';
import '../../persistence/goal_repository_impl.dart';
import '../../persistence/list_repository_impl.dart';
import '../../persistence/list_item_repository_impl.dart';

class ConnectionSelector extends StatefulWidget {
  final NodeType nodeType;
  final List<String> excludeIds;
  final Function(String entityId, String entityName) onSelected;
  final String? filterByListId; // For listItem type, filter by specific list

  const ConnectionSelector({
    super.key,
    required this.nodeType,
    this.excludeIds = const [],
    required this.onSelected,
    this.filterByListId,
  });

  @override
  State<ConnectionSelector> createState() => _ConnectionSelectorState();
}

class _ConnectionSelectorState extends State<ConnectionSelector> {
  List<dynamic> _entities = [];
  List<dynamic> _filteredEntities = [];
  bool _isLoading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEntities();
    _searchController.addListener(_filterEntities);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadEntities() async {
    setState(() {
      _isLoading = true;
    });

    final database = db.AppDatabase();

    try {
      List<dynamic> entities;

      switch (widget.nodeType) {
        case NodeType.task:
          final repository = TaskRepositoryImpl(database);
          entities = await repository.getAllTasks();
          break;
        case NodeType.goal:
          final repository = GoalRepositoryImpl(database);
          entities = await repository.getAllGoals();
          break;
        case NodeType.list:
          final repository = ListRepositoryImpl(database);
          entities = await repository.getAllLists();
          break;
        case NodeType.listItem:
          final repository = ListItemRepositoryImpl(database);
          if (widget.filterByListId != null) {
            entities = await repository.getListItemsByListId(widget.filterByListId!);
          } else {
            entities = await repository.getAllListItems();
          }
          break;
      }

      // Filter out excluded IDs
      entities = entities.where((entity) {
        final id = _getEntityId(entity);
        return !widget.excludeIds.contains(id);
      }).toList();

      setState(() {
        _entities = entities;
        _filteredEntities = entities;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading entities: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  void _filterEntities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEntities = _entities.where((entity) {
        final name = _getEntityName(entity).toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  String _getEntityId(dynamic entity) {
    if (entity is Task) return entity.id;
    if (entity is Goal) return entity.id;
    if (entity is ProgressList) return entity.id;
    if (entity is ListItem) return entity.id;
    return '';
  }

  String _getEntityName(dynamic entity) {
    if (entity is Task) return entity.title;
    if (entity is Goal) return entity.name;
    if (entity is ProgressList) return entity.name;
    if (entity is ListItem) return entity.title;
    return '';
  }

  String _getEntitySubtitle(dynamic entity) {
    if (entity is Task) {
      return '${entity.timeframe.name} • ${entity.completionRuleType.name}';
    }
    if (entity is Goal) {
      return entity.timeframe?.name ?? 'No timeframe';
    }
    if (entity is ProgressList) {
      return entity.type ?? 'List';
    }
    if (entity is ListItem) {
      return entity.notes ?? '';
    }
    return '';
  }

  IconData _getEntityIcon(dynamic entity) {
    if (entity is Task) return Icons.task_outlined;
    if (entity is Goal) return Icons.flag_outlined;
    if (entity is ProgressList) return Icons.list_outlined;
    if (entity is ListItem) return Icons.check_box_outlined;
    return Icons.help_outline;
  }

  String _getTypeLabel() {
    switch (widget.nodeType) {
      case NodeType.task:
        return 'Tasks';
      case NodeType.goal:
        return 'Goals';
      case NodeType.list:
        return 'Lists';
      case NodeType.listItem:
        return 'List Items';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select ${_getTypeLabel()}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search ${_getTypeLabel().toLowerCase()}...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredEntities.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _searchController.text.isNotEmpty
                                  ? Icons.search_off
                                  : Icons.inbox_outlined,
                              size: 64,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchController.text.isNotEmpty
                                  ? 'No results found'
                                  : 'No ${_getTypeLabel().toLowerCase()} available',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredEntities.length,
                        itemBuilder: (context, index) {
                          final entity = _filteredEntities[index];
                          final id = _getEntityId(entity);
                          final name = _getEntityName(entity);
                          final subtitle = _getEntitySubtitle(entity);
                          final icon = _getEntityIcon(entity);

                          return ListTile(
                            leading: Icon(icon),
                            title: Text(name),
                            subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
                            onTap: () {
                              widget.onSelected(id, name);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
