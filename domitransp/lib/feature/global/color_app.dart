import 'package:flutter/material.dart';

class ColorApp {
  static Color fondo({Color? color}) => color ?? const Color.fromRGBO(44, 44, 44, 17);

  static Color decorador({Color? color}) {
    if(color != null){
      return color;
    } else{
      return color ?? const Color.fromRGBO(44, 44, 44, 17);
    }
  }


  static Color principal({Color? color}) => color ?? const Color.fromRGBO(79, 0, 148, 58);

  static Color frioAnalogo({Color? color}) => color ?? const Color.fromRGBO(0, 17, 148, 58);

  static Color frio({Color? color}) => color ?? const Color.fromRGBO(30, 0, 148, 58);

  static Color calido({Color? color}) => color ?? const Color.fromRGBO(127, 0, 148, 58);

  static Color calidoAnalogo({Color? color}) => color ?? const Color.fromRGBO(147, 0, 97, 58);
}
