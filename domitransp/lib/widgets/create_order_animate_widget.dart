import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../feature/global/fonts.dart';

class CreateOrderAnimateWidget extends StatelessWidget {
  String? message;
  CreateOrderAnimateWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.521),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'animations/animacion_creando_pedido.json',
              height: 300,
              // reverse: true,
              // fit: BoxFit.cover
            ),
            message is String
                ? Text(
                    message!,
                    style: Fonts.personalizado(sizeFont: 26.0),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
