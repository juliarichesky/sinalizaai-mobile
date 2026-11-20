part of '../map_screen.dart';

/// Desenha o fundo demonstrativo do mapa.
///
/// Mantido separado da tela para que a composição visual do mapa possa evoluir
/// sem misturar regras de navegação e seleção de pontos.
class _MapPainter extends CustomPainter {
  const _MapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFFF1EFF2);
    canvas.drawRect(Offset.zero & size, background);

    _drawGreenAreas(canvas, size);
    _drawBlocks(canvas, size);
    _drawRoads(canvas, size);
    _drawWaterway(canvas, size);
  }

  void _drawGreenAreas(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFD9ECCB);
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(size.width * 0.23, 0)
        ..lineTo(size.width * 0.14, size.height * 0.2)
        ..lineTo(0, size.height * 0.27)
        ..close(),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.76, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height * 0.25)
        ..lineTo(size.width * 0.82, size.height * 0.19)
        ..close(),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.74, size.height * 0.64)
        ..lineTo(size.width, size.height * 0.56)
        ..lineTo(size.width, size.height * 0.84)
        ..lineTo(size.width * 0.82, size.height * 0.92)
        ..close(),
      paint,
    );
  }

  void _drawBlocks(Canvas canvas, Size size) {
    final fill = Paint()..color = const Color(0xFFE8E4E8);
    final stroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    const columns = 5;
    const rows = 7;
    final blockWidth = size.width / columns;
    final blockHeight = size.height / rows;

    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        final left = column * blockWidth + 4;
        final top = row * blockHeight + 4;
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, blockWidth - 8, blockHeight - 8),
          const Radius.circular(3),
        );
        canvas.drawRRect(rect, fill);
        canvas.drawRRect(rect, stroke);
      }
    }
  }

  void _drawRoads(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round;
    final detail = Paint()
      ..color = const Color(0xFFD8D3DA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final roads = [
      [Offset(0, size.height * 0.28), Offset(size.width, size.height * 0.73)],
      [Offset(size.width * 0.15, 0), Offset(size.width * 0.8, size.height)],
      [Offset(0, size.height * 0.78), Offset(size.width, size.height * 0.18)],
      [Offset(size.width * 0.72, 0), Offset(size.width * 0.25, size.height)],
    ];

    for (final road in roads) {
      canvas.drawLine(road[0], road[1], paint);
      canvas.drawLine(road[0], road[1], detail);
    }
  }

  void _drawWaterway(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF9FD2EA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final path = Path()
      ..moveTo(size.width * 0.08, size.height)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.76,
        size.width * 0.13,
        size.height * 0.47,
        size.width * 0.38,
        size.height * 0.26,
      )
      ..cubicTo(
        size.width * 0.55,
        size.height * 0.12,
        size.width * 0.7,
        size.height * 0.3,
        size.width,
        size.height * 0.05,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) => false;
}
