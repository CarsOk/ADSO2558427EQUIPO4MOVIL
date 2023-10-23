import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingChatAnimate extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('animations/animation_chat_index.json',
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