import 'package:flutter/material.dart';

import 'package:domitransp/core/data/repository/consult_dto.dart';
import 'consult.dart';

class FailureConsultWidget extends StatelessWidget {
  final message;
  const FailureConsultWidget({super.key, required this.message});

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
          Text(message),
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
                  builder: (context) => Consult(),
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
