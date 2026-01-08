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

  Timeframe? _selectedTimeframe;
  MetricType? _selectedMetricType;
  String? _metricUnit;
  double? _metricTarget;

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      _nameController.text = widget.goal!.name;
      _descriptionController.text = widget.goal!.description ?? '';
      _selectedTimeframe = widget.goal!.timeframe;
      _selectedMetricType = widget.goal!.metricType;
      _metricUnit = widget.goal!.metricUnit;
      _metricTarget = widget.goal!.metricTarget;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveGoal() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final goal = Goal(
        id: widget.goal?.id ?? const Uuid().v4(),
        name: _nameController.text,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null,
        timeframe: _selectedTimeframe,
        metricType: _selectedMetricType,
        metricUnit: _metricUnit,
        metricTarget: _metricTarget,
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

        if (mounted) {
          Navigator.of(context).pop(true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving goal: $e')),
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
        title: Text(widget.goal == null ? 'New Goal' : 'Edit Goal'),
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
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Timeframe?>(
              value: _selectedTimeframe,
              decoration: const InputDecoration(
                labelText: 'Timeframe (optional)',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('None'),
                ),
                ...Timeframe.values.map((timeframe) {
                  return DropdownMenuItem(
                    value: timeframe,
                    child: Text(timeframe.name.toUpperCase()),
                  );
                }),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedTimeframe = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<MetricType?>(
              value: _selectedMetricType,
              decoration: const InputDecoration(
                labelText: 'Metric Type (optional)',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('None'),
                ),
                ...MetricType.values.where((t) => t != MetricType.none).map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  );
                }),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedMetricType = value;
                  if (value == null) {
                    _metricUnit = null;
                    _metricTarget = null;
                  }
                });
              },
            ),
            if (_selectedMetricType != null) ...[
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
}
