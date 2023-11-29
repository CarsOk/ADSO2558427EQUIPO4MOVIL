import 'package:flutter/material.dart';

class ColorApp {
  static Color fondo({Color? color}) =>
      color ?? const Color.fromARGB(255, 32, 32, 32);

  static Color decorador({Color? color}) {
    if (color != null) {
      return color;
    } else {
      return color ?? const Color.fromARGB(255, 51, 51, 51);
    }
  }

  static Color principal({Color? color}) {
    if (color != null) {
      return color;
    } else {
      return color ?? const Color.fromRGBO(79, 0, 148, 58);
    }
  }

  static Color frioAnalogo({Color? color}) {
    if (color != null) {
      return color;
    } else {
      return const Color.fromRGBO(0, 17, 148, 58);
    }
  }

  static Color frio({Color? color}) {
    if (color != null) {
      return color;
    } else {
      return const Color.fromRGBO(30, 0, 148, 58);
    }
  }

  static Color calido({Color? color}) {
    if (color != null) {
      return color;
    } else {
      return const Color.fromRGBO(127, 0, 148, 58);
    }
  }

  static Color calidoAnalogo({Color? color}) {
    if (color != null) {
      return color;
    } else {
      return const Color.fromRGBO(147, 0, 97, 58);
    }
  }

  // ignore: non_constant_identifier_names
  static Widget IconoDegrado({required IconData icono, double size = 20}) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            ColorApp.frio(),
            ColorApp.calidoAnalogo(),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      child: Icon(
        icono,
        color: Colors.white,
        size: size,
      ),
    );
  }
}
