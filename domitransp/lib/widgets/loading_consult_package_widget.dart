import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingConsultPackageWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('animations/animation_consult_package.json',
            height: 300,
            // reverse: true,
            // fit: BoxFit.cover
            ),
            // SizedBox(height: 10,),
            Text(
              'Consultando pedido', 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(0, 0, 0, 0.707),
                ),
            ),
          ],
        ),
      ),
    );
  }

}