import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/list.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/list_repository_impl.dart';

class ListFormScreen extends StatefulWidget {
  final ProgressList? list;

  const ListFormScreen({super.key, this.list});

  @override
  State<ListFormScreen> createState() => _ListFormScreenState();
}

class _ListFormScreenState extends State<ListFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.list != null) {
      _nameController.text = widget.list!.name;
      _typeController.text = widget.list!.type ?? '';
      _descriptionController.text = widget.list!.description ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveList() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final list = ProgressList(
        id: widget.list?.id ?? const Uuid().v4(),
        name: _nameController.text,
        type: _typeController.text.isNotEmpty ? _typeController.text : null,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null,
        positionX: widget.list?.positionX ?? 0.0,
        positionY: widget.list?.positionY ?? 0.0,
        createdAt: widget.list?.createdAt ?? now,
        updatedAt: now,
      );

      final database = db.AppDatabase();
      final repository = ListRepositoryImpl(database);

      try {
        if (widget.list == null) {
          await repository.createList(list);
        } else {
          await repository.updateList(list);
        }

        if (mounted) {
          Navigator.of(context).pop(true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving list: $e')),
          );
        }
      } finally {
        await database.close();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list == null ? 'New List' : 'Edit List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveList,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _typeController,
              decoration: const InputDecoration(
                labelText: 'Type (optional)',
                hintText: 'e.g., movies, restaurants, books',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
