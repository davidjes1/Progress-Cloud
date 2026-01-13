import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/list_item.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/list_item_repository_impl.dart';

class ListItemFormScreen extends StatefulWidget {
  final String listId;
  final ListItem? item;

  const ListItemFormScreen({
    super.key,
    required this.listId,
    this.item,
  });

  @override
  State<ListItemFormScreen> createState() => _ListItemFormScreenState();
}

class _ListItemFormScreenState extends State<ListItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _titleController.text = widget.item!.title;
      _notesController.text = widget.item!.notes ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final database = db.AppDatabase();
    final repository = ListItemRepositoryImpl(database);

    try {
      final now = DateTime.now();
      final item = ListItem(
        id: widget.item?.id ?? const Uuid().v4(),
        listId: widget.listId,
        title: _titleController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        metadata: widget.item?.metadata ?? {},
        isCompleted: widget.item?.isCompleted ?? false,
        positionX: widget.item?.positionX ?? 0.0,
        positionY: widget.item?.positionY ?? 0.0,
        createdAt: widget.item?.createdAt ?? now,
        updatedAt: now,
      );

      if (widget.item == null) {
        await repository.createListItem(item);
      } else {
        await repository.updateListItem(item);
      }

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving item: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
        actions: [
          if (!_isLoading)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveItem,
            )
          else
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                hintText: 'Enter item title',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
                hintText: 'Optional notes',
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _saveItem,
              icon: const Icon(Icons.save),
              label: Text(widget.item == null ? 'Create Item' : 'Update Item'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
