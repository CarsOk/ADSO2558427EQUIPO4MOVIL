import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {
  static title() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static titleThin() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static subtitle() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static text01() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: 6.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static text02() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: 8.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static text03() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: 10.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static personalizado({sizeFont}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: sizeFont ?? 10.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static text1() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static text2() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static text3() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.945),
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}
