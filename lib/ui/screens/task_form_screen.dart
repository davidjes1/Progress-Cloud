import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/task.dart';
import '../../domain/models/enums.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/task_repository_impl.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Timeframe _selectedTimeframe = Timeframe.daily;
  CompletionRuleType _selectedCompletionRule = CompletionRuleType.boolean;
  MetricType _selectedMetricType = MetricType.none;
  String? _metricUnit;
  double? _metricTarget;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';
      _selectedTimeframe = widget.task!.timeframe;
      _selectedCompletionRule = widget.task!.completionRuleType;
      _selectedMetricType = widget.task!.metricType;
      _metricUnit = widget.task!.metricUnit;
      _metricTarget = widget.task!.metricTarget;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final task = Task(
        id: widget.task?.id ?? const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null,
        timeframe: _selectedTimeframe,
        completionRuleType: _selectedCompletionRule,
        metricType: _selectedMetricType,
        metricUnit: _metricUnit,
        metricTarget: _metricTarget,
        isCompleted: widget.task?.isCompleted ?? false,
        positionX: widget.task?.positionX ?? 0.0,
        positionY: widget.task?.positionY ?? 0.0,
        createdAt: widget.task?.createdAt ?? now,
        updatedAt: now,
      );

      final database = db.AppDatabase();
      final repository = TaskRepositoryImpl(database);

      try {
        if (widget.task == null) {
          await repository.createTask(task);
        } else {
          await repository.updateTask(task);
        }

        if (mounted) {
          Navigator.of(context).pop(true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving task: $e')),
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
        title: Text(widget.task == null ? 'New Task' : 'Edit Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveTask,
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
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
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
            const SizedBox(height: 16),
            DropdownButtonFormField<Timeframe>(
              value: _selectedTimeframe,
              decoration: const InputDecoration(
                labelText: 'Timeframe',
                border: OutlineInputBorder(),
              ),
              items: Timeframe.values.map((timeframe) {
                return DropdownMenuItem(
                  value: timeframe,
                  child: Text(timeframe.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTimeframe = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<CompletionRuleType>(
              value: _selectedCompletionRule,
              decoration: const InputDecoration(
                labelText: 'Completion Type',
                border: OutlineInputBorder(),
              ),
              items: CompletionRuleType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(_formatCompletionRuleType(type)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCompletionRule = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<MetricType>(
              value: _selectedMetricType,
              decoration: const InputDecoration(
                labelText: 'Metric Type',
                border: OutlineInputBorder(),
              ),
              items: MetricType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMetricType = value!;
                  if (value == MetricType.none) {
                    _metricUnit = null;
                    _metricTarget = null;
                  }
                });
              },
            ),
            if (_selectedMetricType != MetricType.none) ...[
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Metric Unit (e.g., miles, minutes)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _metricUnit,
                onChanged: (value) {
                  _metricUnit = value.isNotEmpty ? value : null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Target Value (optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                initialValue: _metricTarget?.toString(),
                onChanged: (value) {
                  _metricTarget = double.tryParse(value);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatCompletionRuleType(CompletionRuleType type) {
    switch (type) {
      case CompletionRuleType.boolean:
        return 'Yes/No';
      case CompletionRuleType.countBased:
        return 'Count Based';
      case CompletionRuleType.metricBased:
        return 'Metric Based';
      case CompletionRuleType.streak:
        return 'Streak';
    }
  }
}
