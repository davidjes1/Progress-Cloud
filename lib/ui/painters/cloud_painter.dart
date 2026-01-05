import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Represents a visual node in the cloud
class CloudNode {
  final String id;
  final String title;
  final Offset position;
  final Color color;
  final NodeShape shape;
  final double size;

  const CloudNode({
    required this.id,
    required this.title,
    required this.position,
    required this.color,
    this.shape = NodeShape.circle,
    this.size = 60.0,
  });
}

/// Represents a visual connection between nodes
class CloudConnection {
  final String id;
  final String fromNodeId;
  final String toNodeId;
  final Color color;
  final double strokeWidth;

  const CloudConnection({
    required this.id,
    required this.fromNodeId,
    required this.toNodeId,
    this.color = Colors.grey,
    this.strokeWidth = 2.0,
  });
}

enum NodeShape {
  circle,
  square,
  diamond,
  hexagon,
}

/// Custom painter for rendering the cloud visualization
class CloudPainter extends CustomPainter {
  final double scale;
  final Offset offset;
  final List<CloudNode> nodes;
  final List<CloudConnection> connections;

  CloudPainter({
    required this.scale,
    required this.offset,
    required this.nodes,
    required this.connections,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Apply transformations
    canvas.save();
    canvas.translate(size.width / 2 + offset.dx, size.height / 2 + offset.dy);
    canvas.scale(scale);

    // Draw grid for reference
    _drawGrid(canvas, size);

    // Draw connections first (so they appear behind nodes)
    for (final connection in connections) {
      _drawConnection(canvas, connection);
    }

    // Draw nodes
    for (final node in nodes) {
      _drawNode(canvas, node);
    }

    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const gridSpacing = 50.0;
    final gridSize = 2000.0;

    // Vertical lines
    for (double x = -gridSize; x <= gridSize; x += gridSpacing) {
      canvas.drawLine(
        Offset(x, -gridSize),
        Offset(x, gridSize),
        gridPaint,
      );
    }

    // Horizontal lines
    for (double y = -gridSize; y <= gridSize; y += gridSpacing) {
      canvas.drawLine(
        Offset(-gridSize, y),
        Offset(gridSize, y),
        gridPaint,
      );
    }
  }

  void _drawConnection(Canvas canvas, CloudConnection connection) {
    // Find the from and to nodes
    final fromNode = nodes.where((n) => n.id == connection.fromNodeId).firstOrNull;
    final toNode = nodes.where((n) => n.id == connection.toNodeId).firstOrNull;

    if (fromNode == null || toNode == null) return;

    final paint = Paint()
      ..color = connection.color
      ..strokeWidth = connection.strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw curved line
    final path = Path();
    path.moveTo(fromNode.position.dx, fromNode.position.dy);

    // Calculate control point for bezier curve
    final midPoint = Offset(
      (fromNode.position.dx + toNode.position.dx) / 2,
      (fromNode.position.dy + toNode.position.dy) / 2,
    );
    final controlPoint = Offset(
      midPoint.dx,
      midPoint.dy - 50,
    );

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      toNode.position.dx,
      toNode.position.dy,
    );

    canvas.drawPath(path, paint);
  }

  void _drawNode(Canvas canvas, CloudNode node) {
    final paint = Paint()
      ..color = node.color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = node.color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Draw shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const ui.MaskFilter.blur(BlurStyle.normal, 4.0);

    switch (node.shape) {
      case NodeShape.circle:
        canvas.drawCircle(node.position + const Offset(2, 2), node.size / 2, shadowPaint);
        canvas.drawCircle(node.position, node.size / 2, paint);
        canvas.drawCircle(node.position, node.size / 2, borderPaint);
        break;

      case NodeShape.square:
        final rect = Rect.fromCenter(
          center: node.position + const Offset(2, 2),
          width: node.size,
          height: node.size,
        );
        canvas.drawRect(rect, shadowPaint);

        final mainRect = Rect.fromCenter(
          center: node.position,
          width: node.size,
          height: node.size,
        );
        canvas.drawRect(mainRect, paint);
        canvas.drawRect(mainRect, borderPaint);
        break;

      case NodeShape.diamond:
        _drawDiamond(canvas, node, paint, borderPaint, shadowPaint);
        break;

      case NodeShape.hexagon:
        _drawHexagon(canvas, node, paint, borderPaint, shadowPaint);
        break;
    }

    // Draw title
    final textPainter = TextPainter(
      text: TextSpan(
        text: node.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: node.size * 1.5);

    final textOffset = Offset(
      node.position.dx - textPainter.width / 2,
      node.position.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, textOffset);
  }

  void _drawDiamond(Canvas canvas, CloudNode node, Paint paint, Paint borderPaint, Paint shadowPaint) {
    final path = Path();
    final halfSize = node.size / 2;

    path.moveTo(node.position.dx, node.position.dy - halfSize);
    path.lineTo(node.position.dx + halfSize, node.position.dy);
    path.lineTo(node.position.dx, node.position.dy + halfSize);
    path.lineTo(node.position.dx - halfSize, node.position.dy);
    path.close();

    final shadowPath = path.shift(const Offset(2, 2));
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  void _drawHexagon(Canvas canvas, CloudNode node, Paint paint, Paint borderPaint, Paint shadowPaint) {
    final path = Path();
    final radius = node.size / 2;
    final angle = (2 * 3.14159) / 6;

    for (int i = 0; i < 6; i++) {
      final angleInDegrees = 60.0 * i - 30.0;
      final angleInRadians = angleInDegrees * 3.14159 / 180;
      final x = node.position.dx + radius * ui.cos(angleInRadians);
      final y = node.position.dy + radius * ui.sin(angleInRadians);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    final shadowPath = path.shift(const Offset(2, 2));
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CloudPainter oldDelegate) {
    return oldDelegate.scale != scale ||
        oldDelegate.offset != offset ||
        oldDelegate.nodes != nodes ||
        oldDelegate.connections != connections;
  }
}
