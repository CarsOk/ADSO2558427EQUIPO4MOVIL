import 'package:flutter/material.dart';

class LoadingAnimate extends StatelessWidget {
  final String message;

  const LoadingAnimate({
    Key? key,
    this.message = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alto = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromARGB(229, 219, 217, 217).withOpacity(0.80),
      child: Stack(alignment: Alignment.center, children: [
        CuadradoAnimado(
          color: Color.fromARGB(255, 255, 255, 255),
          rotar: false,
        ),
        CuadradoAnimado(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        Icon(
          Icons.directions_car,
          color: Colors.white,
          size: 36.0,
        ),
        Positioned(
          bottom: alto * 0.37,
          child: Text(
            message,
            style: Theme.of(context).textTheme.subtitle1,
            // style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  final Color color;
  final bool rotar;

  const CuadradoAnimado({Key? key, required this.color, this.rotar = true})
      : super(key: key);

  @override
  _CuadradoAnimadoState createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotacion;
  late Animation<double> agrandar;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));

    if (widget.rotar) {
      rotacion = Tween(begin: -0.2, end: 2.0).animate(controller);
    } else {
      rotacion = Tween(begin: 2.0, end: 0.0).animate(controller);
    }
    agrandar = Tween(begin: 0.8, end: 1.2).animate(controller);

    controller.addListener(() {
      // print('Status => ${controller.status}');
      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
      } else if (controller.status == AnimationStatus.dismissed) {
        // controller.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(); // Play

    return AnimatedBuilder(
      animation: rotacion,
      child: _Rectangulo(widget.color),
      builder: (BuildContext context, Widget? childRectangulo) {
        // print('Valor de la rotacion => ${rotacion.value}');
        return Transform.rotate(
          angle: rotacion.value,
          child: Transform.scale(
            scale: agrandar.value,
            child: childRectangulo,
          ),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  final Color color;

  const _Rectangulo(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
