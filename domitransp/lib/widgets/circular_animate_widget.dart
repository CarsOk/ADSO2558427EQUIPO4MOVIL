import 'package:flutter/material.dart';
import '../feature/global/color_app.dart';

class CircularAnimateWidget extends StatelessWidget {
  const CircularAnimateWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 550,
        child: Center(
          child: CircularProgressIndicator(
            color: ColorApp.principal(),
          ),
        ),
      ),
    );
  }
}
