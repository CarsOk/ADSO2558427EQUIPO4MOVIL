import 'package:flutter/material.dart';

class CustomLoadingAnimation extends StatefulWidget {
  @override
  _CustomLoadingAnimationState createState() => _CustomLoadingAnimationState();
}

class _CustomLoadingAnimationState extends State<CustomLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> scaling;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    rotation = Tween(begin: 0.0, end: 2 * 3.14159265359).animate(controller);
    scaling = Tween(begin: 0.5, end: 1.0).animate(controller);

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFd5c4e6),
      child: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: rotation.value,
              child: Transform.scale(
                scale: scaling.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF4E0096),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 48.0,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}