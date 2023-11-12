import 'package:flutter/material.dart';

class CategoryIconWidget extends StatelessWidget{
  double altura;
  double anchura;
  double tamanoIcono;
  String nombre;
  Function()? onTap;
  IconData icono;
  CategoryIconWidget({super.key, this.altura = 200, this.anchura = 200, this.tamanoIcono = 50, required this.icono, required this.onTap, required this.nombre});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Column(
        children: [
          Container(
            width: anchura,
            height: altura,
            decoration: BoxDecoration(
              color: Color.fromRGBO(180, 100, 250, 98),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icono, color: Colors.white, size: tamanoIcono),
          ),
          SizedBox(
            height: 10,
          ),
          Text(nombre,
            style: const TextStyle(
              
            ),
          ),
        ],
      ),
    );
  }
}