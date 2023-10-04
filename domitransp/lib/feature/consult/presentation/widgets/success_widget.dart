import 'package:flutter/material.dart';

import 'package:domitransp/core/data/repository/consult_dto.dart';
import 'package:domitransp/feature/consult/presentation/widgets/consult.dart';

class SuccessConsultWidget extends StatelessWidget {
  final ConsultaDto consultDto;
  const SuccessConsultWidget({super.key, required this.consultDto});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Información del envío',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text('Origen: ' + consultDto.origen),
          Text('Destino: ' + consultDto.destino),
          Text('Estado: ' + consultDto.estado),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Consult(), // Reemplaza "Consult()" con la clase de tu vista de consultas
              ),
            );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

// if (registros.isNotEmpty) {
//                             final registro = registros.first;
//                             final id = registro['id'];
//                             final fecha = registro['fecha'];
//                             final consecutivo = registro['consecutivo'];
//                             final destino = registro['destino'];
//                             final origen = registro['origen'];

//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   content: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         'Información del envío',
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       const SizedBox(height: 20),
//                                       Text('ID: $id'),
//                                       Text('Fecha: $fecha'),
//                                       Text('Consecutivo: $consecutivo'),
//                                       Text('Destino: $destino'),
//                                       Text('Origen: $origen'),
//                                       const SizedBox(height: 20),
//                                       ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           primary: Colors.deepPurple,
//                                           onPrimary: Colors.white,
//                                         ),
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text('OK'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           }