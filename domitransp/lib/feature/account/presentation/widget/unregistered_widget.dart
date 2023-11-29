import 'package:flutter/material.dart';

import '../../../global/color_app.dart';
import '../../../global/fonts.dart';

class UnregisteredWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/picture/imagen/iniciarSesion2.png'),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                children: [
                  Text(
                    'Inicie sesión para disfrutar de una experiencia completa',
                    textAlign: TextAlign.center,
                    style: Fonts.text2(),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'sign_in');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ColorApp.calido(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Entrar',
                        style: Fonts.text3(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
