import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../feature/global/color_app.dart';

class GeneralAnimateLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.fondo(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'animations/general_animation_loading.json',
              height: 300,
              // reverse: true,
              // fit: BoxFit.cover
            ),
          ],
        ),
      ),
    );
  }
}
