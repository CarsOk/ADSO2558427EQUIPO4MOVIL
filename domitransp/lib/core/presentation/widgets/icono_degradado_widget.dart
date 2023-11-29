import 'package:flutter/material.dart';

import '../../../feature/global/color_app.dart';

// ignore: must_be_immutable
class IconoDegradadoWidget extends StatelessWidget {
  IconData icono;
  bool? activo;
  double size;
  IconoDegradadoWidget(
      {super.key, required this.icono, this.activo = false, this.size = 30.0});
  @override
  Widget build(BuildContext context) {
    if (activo!) {
      return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [
              ColorApp.calidoAnalogo(),
              ColorApp.frio(),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds);
        },
        child: Icon(
          icono,
          size: size,
          color: Colors.white,
        ),
      );
    } else {
      return Icon(
        icono,
        size: size,
        color: Color.fromARGB(255, 104, 104, 104),
      );
    }
  }
}
