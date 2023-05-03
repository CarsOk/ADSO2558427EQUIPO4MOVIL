import 'package:flutter/material.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 156, 216, 224),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomRight,
                child: Container(
                  padding: EdgeInsets.only(
                    right: 5, left: 5, top:50, bottom:50),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 85, 224, 224),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200)
                    )
                  ),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("¡Bienvenido!", style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 5
                      ),),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset("assets/logo1.png",
                    width: MediaQuery.of(context).size.width/2,
                    height:200,
                  ),
                ),
              ],
            )
          ],
        )
      )
    );
  }
}