import 'package:flutter/material.dart';
import '../painters/cloud_painter.dart';

class CloudViewScreen extends StatefulWidget {
  const CloudViewScreen({super.key});

  @override
  State<CloudViewScreen> createState() => _CloudViewScreenState();
}

class _CloudViewScreenState extends State<CloudViewScreen> {
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  Offset? _lastFocalPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Cloud'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddNodeMenu(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.center_focus_strong),
            onPressed: () {
              setState(() {
                _scale = 1.0;
                _offset = Offset.zero;
              });
            },
            tooltip: 'Reset View',
          ),
        ],
      ),
      body: GestureDetector(
        onScaleStart: (details) {
          _lastFocalPoint = details.focalPoint;
        },
        onScaleUpdate: (details) {
          setState(() {
            // Handle zoom
            _scale = (_scale * details.scale).clamp(0.5, 3.0);

            // Handle pan
            if (_lastFocalPoint != null) {
              final delta = details.focalPoint - _lastFocalPoint!;
              _offset += delta;
            }
            _lastFocalPoint = details.focalPoint;
          });
        },
        onScaleEnd: (details) {
          _lastFocalPoint = null;
        },
        child: CustomPaint(
          painter: CloudPainter(
            scale: _scale,
            offset: _offset,
            nodes: const [], // Will be populated from state
            connections: const [], // Will be populated from state
          ),
          size: Size.infinite,
        ),
      ),
    );
  }

  void _showAddNodeMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Add Task'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to task creation
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Add Goal'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to goal creation
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Add List'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to list creation
              },
            ),
          ],
        ),
      ),
    );
  }
}
