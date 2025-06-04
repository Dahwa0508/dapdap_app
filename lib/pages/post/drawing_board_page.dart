import 'package:flutter/material.dart';

class DrawingBoardPage extends StatefulWidget {
  const DrawingBoardPage({super.key});

  @override
  State<DrawingBoardPage> createState() => _DrawingBoardPageState();
}

class _DrawingBoardPageState extends State<DrawingBoardPage> {
  List<DrawPoint?> points = [];
  Color selectedColor = Colors.black;
  bool isEraser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E4C10),
        title: const Text('칠판'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brush),
            onPressed: () => setState(() => points.clear()),
          ),
          IconButton(
            icon: Icon(isEraser ? Icons.brush : Icons.delete),
            onPressed: () {
              setState(() {
                isEraser = !isEraser;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 색상 선택 바
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _colorCircle(Colors.black),
              _colorCircle(Colors.red),
              _colorCircle(Colors.blue),
              _colorCircle(Colors.green),
              _colorCircle(Colors.orange),
            ],
          ),
          const SizedBox(height: 8),
          // 그리기 영역
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                setState(() {
                  points.add(DrawPoint(
                    offset: renderBox.globalToLocal(details.globalPosition),
                    color: isEraser ? Colors.white : selectedColor,
                  ));
                });
              },
              onPanEnd: (_) => points.add(null),
              child: CustomPaint(
                painter: DrawingPainter(points),
                size: Size.infinite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorCircle(Color color) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedColor = color;
        isEraser = false;
      }),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 14,
        child: selectedColor == color && !isEraser
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : null,
      ),
    );
  }
}

class DrawPoint {
  final Offset offset;
  final Color color;

  DrawPoint({required this.offset, required this.color});
}

class DrawingPainter extends CustomPainter {
  final List<DrawPoint?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      if (p1 != null && p2 != null) {
        final paint = Paint()
          ..color = p1.color
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(p1.offset, p2.offset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}