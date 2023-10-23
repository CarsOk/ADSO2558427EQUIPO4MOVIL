import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FailureWidget extends StatelessWidget{

  Function()? function;
  String message;

  FailureWidget({required this.function, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('animations/error_animation.json',
            height: 300,
            // reverse: true,
            // fit: BoxFit.cover
            ),
            // SizedBox(height: 10,),
            Text(
              message, 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(0, 0, 0, 0.707),
                ),
            ),
            SizedBox(height: 8,),
            InkWell(
              onTap: function,
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFF4E0096),
                ),
                child: Center(
                  child: 
                  // Icon( 
                  //   Icons.replay_outlined,
                  //   weight: 20,
                  //   color: Colors.white,
                  // ),
                  Text(
                    'Reintentar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(251, 251, 251, 0.968),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}