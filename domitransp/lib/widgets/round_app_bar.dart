import 'package:flutter/material.dart';

class AppBarRedondo extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.blue, // Color de fondo
      ),
      child: AppBar(
        backgroundColor: Color.fromRGBO(79, 0, 148, 58),
        title: Center(child: Image.asset('assets/picture/logo/logoEmpresaAppbar.png', height: 80,)),
        elevation: 0, // Esto elimina la sombra del AppBar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        // ...otros atributos del AppBar
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
