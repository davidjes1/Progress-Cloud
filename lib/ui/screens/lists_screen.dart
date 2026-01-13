import 'package:flutter/material.dart';
import '../../domain/models/list.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/list_repository_impl.dart';
import 'list_form_screen.dart';
import 'list_detail_screen.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  List<ProgressList> _lists = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLists();
  }

  Future<void> _loadLists() async {
    setState(() {
      _isLoading = true;
    });

    final database = db.AppDatabase();
    final repository = ListRepositoryImpl(database);

    try {
      final lists = await repository.getAllLists();
      setState(() {
        _lists = lists;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading lists: $e')),
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

    if (result == true) {
      _loadLists();
    }
  }

  Future<void> _navigateToDetail(ProgressList list) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListDetailScreen(list: list),
      ),
    );

    if (result == true) {
      _loadLists();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _lists.isEmpty
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
                        'No lists yet',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap the + button to create your first list',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _lists.length,
                  itemBuilder: (context, index) {
                    final list = _lists[index];
                    return ListTile(
                      leading: const Icon(Icons.list_outlined),
                      title: Text(list.name),
                      subtitle: list.type != null ? Text(list.type!) : null,
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateToForm(list: list),
                      ),
                      onTap: () => _navigateToDetail(list),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
