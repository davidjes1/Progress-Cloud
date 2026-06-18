import 'package:flutter/material.dart';
import '../painters/cloud_painter.dart';
import '../../domain/models/goal.dart';
import '../../domain/models/task.dart';
import '../../domain/models/list.dart';
import '../../domain/models/enums.dart';
import '../../persistence/database.dart' as db;
import '../../persistence/goal_repository_impl.dart';
import '../../persistence/task_repository_impl.dart';
import '../../persistence/list_repository_impl.dart';
import '../../persistence/connection_repository_impl.dart';
import 'goal_form_screen.dart';
import 'list_form_screen.dart';
import 'goal_detail_screen.dart';
import 'task_detail_screen.dart';
import 'list_detail_screen.dart';

class CloudViewScreen extends StatefulWidget {
  const CloudViewScreen({super.key});

  @override
  State<CloudViewScreen> createState() => _CloudViewScreenState();
}

class _CloudViewScreenState extends State<CloudViewScreen> {
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  Offset? _lastFocalPoint;
  double _lastScale = 1.0;

  List<CloudNode> _nodes = [];
  List<CloudConnection> _connections = [];
  bool _isLoading = true;

  // Maps for tap-to-navigate
  Map<String, NodeType> _nodeTypes = {};
  Map<String, Goal> _goalMap = {};
  Map<String, Task> _taskMap = {};
  Map<String, ProgressList> _listMap = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final database = db.AppDatabase();
    final goalRepo = GoalRepositoryImpl(database);
    final taskRepo = TaskRepositoryImpl(database);
    final listRepo = ListRepositoryImpl(database);
    final connectionRepo = ConnectionRepositoryImpl(database);

    try {
      final goals = await goalRepo.getAllGoals();
      final tasks = await taskRepo.getAllTasks();
      final lists = await listRepo.getAllLists();
      final connections = await connectionRepo.getAllConnections();

      final List<CloudNode> nodes = [];
      final Map<String, NodeType> nodeTypes = {};
      final Map<String, Goal> goalMap = {};
      final Map<String, Task> taskMap = {};
      final Map<String, ProgressList> listMap = {};

      // Goals → circles, blue (large)
      for (int i = 0; i < goals.length; i++) {
        final g = goals[i];
        final hasPosition = g.positionX != 0 || g.positionY != 0;
        final pos = hasPosition
            ? Offset(g.positionX, g.positionY)
            : _autoPosition(i, goals.length, -220, 220);

        nodes.add(CloudNode(
          id: g.id,
          title: _truncate(g.name, 14),
          position: pos,
          color: g.isManuallyCompleted ? Colors.green.shade600 : Colors.blue.shade600,
          shape: NodeShape.circle,
          size: 72,
        ));
        nodeTypes[g.id] = NodeType.goal;
        goalMap[g.id] = g;
      }

      // Tasks → squares, orange/green based on completion (medium)
      for (int i = 0; i < tasks.length; i++) {
        final t = tasks[i];
        final hasPosition = t.positionX != 0 || t.positionY != 0;
        final pos = hasPosition
            ? Offset(t.positionX, t.positionY)
            : _autoPosition(i, tasks.length, 0, 160);

        nodes.add(CloudNode(
          id: t.id,
          title: _truncate(t.title, 14),
          position: pos,
          color: t.isCompleted ? Colors.green.shade500 : Colors.orange.shade600,
          shape: NodeShape.square,
          size: 56,
        ));
        nodeTypes[t.id] = NodeType.task;
        taskMap[t.id] = t;
      }

      // Lists → diamonds, purple (medium-large)
      for (int i = 0; i < lists.length; i++) {
        final l = lists[i];
        final hasPosition = l.positionX != 0 || l.positionY != 0;
        final pos = hasPosition
            ? Offset(l.positionX, l.positionY)
            : _autoPosition(i, lists.length, 220, 220);

        nodes.add(CloudNode(
          id: l.id,
          title: _truncate(l.name, 14),
          position: pos,
          color: Colors.purple.shade500,
          shape: NodeShape.diamond,
          size: 64,
        ));
        nodeTypes[l.id] = NodeType.list;
        listMap[l.id] = l;
      }

      // Build connections — only include ones where both nodes exist
      final nodeIds = nodes.map((n) => n.id).toSet();
      final cloudConnections = connections
          .where((c) =>
              nodeIds.contains(c.fromNodeId) && nodeIds.contains(c.toNodeId))
          .map((c) => CloudConnection(
                id: c.id,
                fromNodeId: c.fromNodeId,
                toNodeId: c.toNodeId,
                color: Colors.grey.withOpacity(0.5),
                strokeWidth: 2.0,
              ))
          .toList();

      setState(() {
        _nodes = nodes;
        _connections = cloudConnections;
        _nodeTypes = nodeTypes;
        _goalMap = goalMap;
        _taskMap = taskMap;
        _listMap = listMap;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading cloud view: $e')),
        );
      }
    } finally {
      await database.close();
    }
  }

  /// Distributes n nodes evenly in a horizontal row centered on x=0 at given y.
  Offset _autoPosition(int index, int total, double y, double spacing) {
    if (total == 0) return Offset(0, y);
    final x = (index - (total - 1) / 2.0) * spacing;
    return Offset(x, y);
  }

  String _truncate(String text, int maxChars) {
    if (text.length <= maxChars) return text;
    return '${text.substring(0, maxChars - 1)}…';
  }

  void _handleTapUp(TapUpDetails details) {
    final screenSize = context.size;
    if (screenSize == null) return;

    // Convert screen tap position to canvas coordinates
    final tapPos = details.localPosition;
    final canvasX = (tapPos.dx - screenSize.width / 2 - _offset.dx) / _scale;
    final canvasY = (tapPos.dy - screenSize.height / 2 - _offset.dy) / _scale;

    // Find hit node (check center hit within half the node size)
    for (final node in _nodes) {
      final halfSize = node.size / 2;
      if ((canvasX - node.position.dx).abs() < halfSize &&
          (canvasY - node.position.dy).abs() < halfSize) {
        _navigateToNode(node.id);
        return;
      }
    }
  }

  void _navigateToNode(String id) {
    final nodeType = _nodeTypes[id];
    if (nodeType == null) return;

    switch (nodeType) {
      case NodeType.goal:
        final goal = _goalMap[id];
        if (goal == null) return;
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) => GoalDetailScreen(goal: goal),
            ))
            .then((_) => _loadData());
        break;
      case NodeType.task:
        final task = _taskMap[id];
        if (task == null) return;
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) => TaskDetailScreen(task: task),
            ))
            .then((_) => _loadData());
        break;
      case NodeType.list:
        final list = _listMap[id];
        if (list == null) return;
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) => ListDetailScreen(list: list),
            ))
            .then((_) => _loadData());
        break;
      case NodeType.listItem:
        // listItems are not shown in cloud view, no-op
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Cloud'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddMenu(context),
            tooltip: 'Add',
          ),
          IconButton(
            icon: const Icon(Icons.center_focus_strong),
            onPressed: () => setState(() {
              _scale = 1.0;
              _offset = Offset.zero;
            }),
            tooltip: 'Reset View',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _nodes.isEmpty
              ? _buildEmptyState()
              : Column(
                  children: [
                    _buildLegend(),
                    Expanded(child: _buildCanvas()),
                  ],
                ),
    );
  }

  Widget _buildCanvas() {
    return GestureDetector(
      onScaleStart: (details) {
        _lastFocalPoint = details.focalPoint;
        _lastScale = _scale;
      },
      onScaleUpdate: (details) {
        setState(() {
          // Pinch to zoom
          _scale = (_lastScale * details.scale).clamp(0.3, 4.0);

          // Pan
          if (_lastFocalPoint != null) {
            final delta = details.focalPoint - _lastFocalPoint!;
            _offset += delta;
          }
          _lastFocalPoint = details.focalPoint;
        });
      },
      onScaleEnd: (_) => _lastFocalPoint = null,
      onTapUp: _handleTapUp,
      child: CustomPaint(
        painter: CloudPainter(
          scale: _scale,
          offset: _offset,
          nodes: _nodes,
          connections: _connections,
        ),
        size: Size.infinite,
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _legendItem(Colors.blue.shade600, 'Goals', NodeShape.circle),
          const SizedBox(width: 16),
          _legendItem(Colors.orange.shade600, 'Steps', NodeShape.square),
          const SizedBox(width: 16),
          _legendItem(Colors.purple.shade500, 'Lists', NodeShape.diamond),
          const SizedBox(width: 16),
          _legendItem(Colors.green.shade500, 'Done', NodeShape.circle),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label, NodeShape shape) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: shape == NodeShape.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
            borderRadius:
                shape == NodeShape.square ? BorderRadius.circular(2) : null,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
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
              Icons.bubble_chart_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            ),
            const SizedBox(height: 24),
            Text(
              'No items to visualize',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Add bucket list items, steps, or collections to see them here.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.star_border_rounded),
              title: const Text('Add Bucket List Item'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const GoalFormScreen(),
                  ),
                );
                if (result == true) _loadData();
              },
            ),
            ListTile(
              leading: const Icon(Icons.collections_bookmark_outlined),
              title: const Text('Add Collection'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ListFormScreen(),
                  ),
                );
                if (result == true) _loadData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
