import 'package:flutter/material.dart';

import '../feature/global/color_app.dart';

class AppBarRedondo extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorApp.decorador(),
      elevation: 0,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(20.0),
      //     bottomRight: Radius.circular(20.0),
      //   ),
      // ),
      flexibleSpace: Center(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                'assets/picture/logo/logoEmpresaAppbar.png',
              ),
            ),
          ),
        ),
      ),
      // ...otros atributos del AppBar
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(68);
}
