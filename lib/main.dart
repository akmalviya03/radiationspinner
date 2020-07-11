import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyRadiationSpinner());
}

class MyRadiationSpinner extends StatefulWidget {
  @override
  _MyRadiationSpinnerState createState() => _MyRadiationSpinnerState();
}

class _MyRadiationSpinnerState extends State<MyRadiationSpinner>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      lowerBound: 0,
      upperBound: 360,
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget child) {
                  return CustomPaint(
                    painter: RadiationLoader(val: _animationController.value),
                  );
                },
              ),
            ),
          ),
        ));
  }
}

class RadiationLoader extends CustomPainter {
  RadiationLoader({@required this.val});
  final val;
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(center: size.center(Offset.zero), radius: 30);

    final sweepAngleForArcs = 60 * math.pi / 180;
    final useCenter = true;
    final paintYellowFill = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final paintBlackFill = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final paintBlackStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    //BigYellowCircle
    canvas.drawCircle(Offset.zero, 40, paintYellowFill);
    //OuterStrokes
    canvas.drawCircle(Offset.zero, 40, paintBlackStroke);

    //Slices
    canvas.drawArc(rect, (val + 60) * math.pi / 180, sweepAngleForArcs,
        useCenter, paintBlackFill);

    canvas.drawArc(rect, (val + 180) * math.pi / 180, sweepAngleForArcs,
        useCenter, paintBlackFill);

    canvas.drawArc(rect, (val + 300) * math.pi / 180, sweepAngleForArcs,
        useCenter, paintBlackFill);

    //Mid Circles
    canvas.drawCircle(Offset.zero, 10, paintYellowFill);
    canvas.drawCircle(Offset.zero, 5, paintBlackFill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
