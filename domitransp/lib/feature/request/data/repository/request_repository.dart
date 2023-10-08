import 'package:postgres/postgres.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class RequestRepository {
  final _baseUrl = 'b5xn4aiw71dpvzecdgzw-postgresql.services.clever-cloud.com';
  final _puerto = 5432;
  final _nombre_base_datos = 'b5xn4aiw71dpvzecdgzw';
  final _usuario = 'u11nk76ov6hufjlqcdvy';
  final _contrasena = 'qESlbEQ5OahuAKZkrhXYjgcNhmoO50';
  String _created_at = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String _updated_at = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  bool sendRequest(){

    //codigo para conectar en postgres y enviar solicitud

    return true;
  }

  Future<bool> insertRequest({required String email,required String name, required String title,required String subject,required String code}) async {
    final connection = PostgreSQLConnection(
        _baseUrl,
        _puerto,
        _nombre_base_datos,
        username: _usuario,
        password: _contrasena,
      );

    try {
      print("Esto es la fecha ${_created_at}");
      print("Esto es la fecha ${_created_at.runtimeType}");
      await connection.open();

      final envio = await connection.query(
        'INSERT INTO requests (title, name, subject, email, code, created_at, updated_at) VALUES (@title, @name, @subject, @email, @code, @created_at, @updated_at)',
        substitutionValues: {
          'title': title,
          'name': name,
          'subject': subject,
          'email': email,
          'code': code,
          'created_at': _created_at,
          'updated_at': _updated_at
        },
      );  
      print('Esto es envio ${envio}');
      print('Esto es envio ${envio.runtimeType}');

      await connection.close();
      print('lo hice bien, guarde los datos');
      return true;
    } catch (e) {
      print("error en $e");
      return false;
    }
  }
}