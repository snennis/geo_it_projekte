import 'package:flutter/material.dart';
import '../models/building_model.dart';

class BuildingMap extends StatelessWidget {
  final Building building;
  final Room? currentRoom;
  final Room? targetRoom;
  final List<Edge>? currentPath;
  final int? currentStepIndex;

  const BuildingMap({
    super.key,
    required this.building,
    this.currentRoom,
    this.targetRoom,
    this.currentPath,
    this.currentStepIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: CustomPaint(
              painter: BuildingMapPainter(
                building: building,
                currentRoom: currentRoom,
                targetRoom: targetRoom,
                currentPath: currentPath,
                currentStepIndex: currentStepIndex,
              ),
              size: const Size(600, 500),
            ),
          ),
        ),
      ),
    );
  }
}

class BuildingMapPainter extends CustomPainter {
  final Building building;
  final Room? currentRoom;
  final Room? targetRoom;
  final List<Edge>? currentPath;
  final int? currentStepIndex;

  BuildingMapPainter({
    required this.building,
    this.currentRoom,
    this.targetRoom,
    this.currentPath,
    this.currentStepIndex,
  });

  // Layout coordinates for rooms
  final Map<String, Rect> roomRects = {
    'F1': Rect.fromLTWH(150, 150, 300, 80), // Flur EG
    '101': Rect.fromLTWH(50, 50, 80, 80),
    '102': Rect.fromLTWH(160, 50, 80, 80),
    '103': Rect.fromLTWH(270, 50, 80, 80),
    'S1': Rect.fromLTWH(420, 150, 60, 80), // Treppenhaus
    'F2': Rect.fromLTWH(150, 300, 300, 80), // Flur 1. OG
    '201': Rect.fromLTWH(50, 420, 80, 80),
    '202': Rect.fromLTWH(160, 420, 80, 80),
    '210': Rect.fromLTWH(270, 420, 80, 80),
  };

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.grey[100]!,
    );

    // Draw floor separators
    canvas.drawLine(
      Offset(0, 250),
      Offset(size.width, 250),
      Paint()
        ..color = Colors.grey[400]!
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    // Draw floor labels
    _drawText(canvas, 'Erdgeschoss', Offset(10, 240), 12, Colors.grey[600]!);
    _drawText(
      canvas,
      '1. Obergeschoss',
      Offset(10, 495),
      12,
      Colors.grey[600]!,
    );

    // Draw rooms
    _drawRooms(canvas);

    // Draw current path
    if (currentPath != null && currentPath!.isNotEmpty) {
      _drawPath(canvas);
    }

    // Draw current position
    if (currentRoom != null && roomRects.containsKey(currentRoom!.id)) {
      _drawCurrentPosition(canvas);
    }

    // Draw target position
    if (targetRoom != null && roomRects.containsKey(targetRoom!.id)) {
      _drawTargetPosition(canvas);
    }
  }

  void _drawRooms(Canvas canvas) {
    for (final entry in roomRects.entries) {
      final roomId = entry.key;
      final rect = entry.value;
      final room = building.getRoomById(roomId);

      if (room == null) continue;

      // Determine color
      Color color = Colors.white;
      if (room == currentRoom) {
        color = Colors.blue[100]!;
      } else if (room == targetRoom) {
        color = Colors.green[100]!;
      } else if (_isRoomInPath(room)) {
        color = Colors.orange[100]!;
      }

      // Draw room rectangle
      canvas.drawRect(
        rect,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );

      // Draw border
      canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.grey[400]!
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );

      // Draw room text
      _drawText(
        canvas,
        room.name,
        Offset(rect.center.dx, rect.center.dy),
        14,
        Colors.black,
        isCentered: true,
      );
    }
  }

  void _drawPath(Canvas canvas) {
    if (currentPath == null || currentPath!.isEmpty) return;

    for (int i = 0; i < currentPath!.length - 1; i++) {
      final fromRoom = currentPath![i].from;
      final toRoom = currentPath![i].to;

      final fromRect = roomRects[fromRoom.id];
      final toRect = roomRects[toRoom.id];

      if (fromRect != null && toRect != null) {
        // Draw connection line
        Paint linePaint;
        if (i < currentStepIndex!) {
          // Already completed
          linePaint = Paint()
            ..color = Colors.green[400]!
            ..strokeWidth = 4;
        } else if (i == currentStepIndex) {
          // Current step
          linePaint = Paint()
            ..color = Colors.red[400]!
            ..strokeWidth = 4;
        } else {
          // Future steps
          linePaint = Paint()
            ..color = Colors.orange[300]!
            ..strokeWidth = 2;
        }

        canvas.drawLine(fromRect.center, toRect.center, linePaint);
      }
    }
  }

  void _drawCurrentPosition(Canvas canvas) {
    final rect = roomRects[currentRoom!.id]!;
    canvas.drawCircle(
      Offset(rect.right - 10, rect.top + 10),
      8,
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      Offset(rect.right - 10, rect.top + 10),
      8,
      Paint()
        ..color = Colors.blue[700]!
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawTargetPosition(Canvas canvas) {
    final rect = roomRects[targetRoom!.id]!;
    canvas.drawCircle(
      Offset(rect.right - 10, rect.top + 10),
      8,
      Paint()
        ..color = Colors.green
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      Offset(rect.right - 10, rect.top + 10),
      8,
      Paint()
        ..color = Colors.green[700]!
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
  }

  bool _isRoomInPath(Room room) {
    if (currentPath == null) return false;
    return currentPath!.any((edge) => edge.from == room || edge.to == room);
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset position,
    double fontSize,
    Color color, {
    bool isCentered = false,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final offset = isCentered
        ? Offset(
            position.dx - textPainter.width / 2,
            position.dy - textPainter.height / 2,
          )
        : position;

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(BuildingMapPainter oldDelegate) {
    return oldDelegate.currentRoom != currentRoom ||
        oldDelegate.targetRoom != targetRoom ||
        oldDelegate.currentPath != currentPath ||
        oldDelegate.currentStepIndex != currentStepIndex;
  }
}
