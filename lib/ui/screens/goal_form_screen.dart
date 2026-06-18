import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/goal.dart';
import '../../domain/models/enums.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/goal_repository_impl.dart';

class GoalFormScreen extends StatefulWidget {
  final Goal? goal;

  const GoalFormScreen({super.key, this.goal});

  @override
  State<GoalFormScreen> createState() => _GoalFormScreenState();
}

class _GoalFormScreenState extends State<GoalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;
  int? _targetYear;
  bool _autoCompleteEnabled = true;

  static const _categories = [
    'Travel',
    'Adventure',
    'Food & Drink',
    'Health',
    'Career',
    'Learning',
    'Creative',
    'Social',
    'Financial',
    'Personal',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      _nameController.text = widget.goal!.name;
      _descriptionController.text = widget.goal!.description ?? '';
      _selectedCategory = widget.goal!.category;
      _targetYear = widget.goal!.targetDate?.year;
      _autoCompleteEnabled = widget.goal!.autoCompleteEnabled;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickTargetYear() async {
    final now = DateTime.now();
    final firstYear = now.year;
    final lastYear = now.year + 50;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Target Year'),
          content: SizedBox(
            width: 200,
            height: 300,
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                return Column(
                  children: [
                    if (_targetYear != null)
                      TextButton(
                        onPressed: () {
                          setState(() => _targetYear = null);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Clear'),
                      ),
                    Expanded(
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 44,
                        perspective: 0.003,
                        physics: const FixedExtentScrollPhysics(),
                        controller: FixedExtentScrollController(
                          initialItem: (_targetYear ?? firstYear) - firstYear,
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() => _targetYear = firstYear + index);
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: lastYear - firstYear + 1,
                          builder: (context, index) {
                            final year = firstYear + index;
                            return Center(
                              child: Text(
                                '$year',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Done'),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveGoal() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final goal = Goal(
        id: widget.goal?.id ?? const Uuid().v4(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        category: _selectedCategory,
        targetDate: _targetYear != null ? DateTime(_targetYear!) : null,
        isManuallyCompleted: widget.goal?.isManuallyCompleted ?? false,
        autoCompleteEnabled: _autoCompleteEnabled,
        positionX: widget.goal?.positionX ?? 0.0,
        positionY: widget.goal?.positionY ?? 0.0,
        createdAt: widget.goal?.createdAt ?? now,
        updatedAt: now,
      );

      final database = db.AppDatabase();
      final repository = GoalRepositoryImpl(database);

      try {
        if (widget.goal == null) {
          await repository.createGoal(goal);
        } else {
          await repository.updateGoal(goal);
        }
        if (mounted) Navigator.of(context).pop(true);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving: $e')),
          );
        }
      } finally {
        await database.close();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.goal == null ? 'New Bucket List Item' : 'Edit Item'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveGoal,
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
                labelText: 'What do you want to do?',
                hintText: 'e.g. Hike the Appalachian Trail',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? 'Please enter a name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            Text('Category', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories.map((cat) {
                final selected = _selectedCategory == cat;
                return FilterChip(
                  label: Text(cat),
                  selected: selected,
                  onSelected: (val) => setState(() =>
                      _selectedCategory = val ? cat : null),
                  selectedColor: colorScheme.primaryContainer,
                  checkmarkColor: colorScheme.onPrimaryContainer,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Target Year', style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 4),
                      Text(
                        _targetYear != null ? '$_targetYear' : 'No target set',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: _targetYear != null
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: _pickTargetYear,
                  child: Text(_targetYear != null ? 'Change' : 'Set Year'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Auto-complete'),
              subtitle: const Text(
                'Mark as done automatically when all connected steps are completed',
              ),
              value: _autoCompleteEnabled,
              onChanged: (value) => setState(() => _autoCompleteEnabled = value),
            ),
          ],
        ),
      ),
    );
  }
}
