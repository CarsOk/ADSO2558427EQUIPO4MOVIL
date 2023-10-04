import 'package:postgres/postgres.dart';

class RequestRepository {
  final _baseUrl = 'bvhfjwkf20bxxmiymhsl-postgresql.services.clever-cloud.com';
  final _puerto = 5432;
  final _nombre_base_datos = 'bvhfjwkf20bxxmiymhsl';
  final _usuario = 'uhodsejm5l5i75kfbjgj';
  final _contrasena = '81vkBW4M8QAQETmVieuThN0ZdnRbtU';
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
      
      await connection.open();

      await connection.query(
        'INSERT INTO requests (title, name, subject, email, code) VALUES (@title, @name, @subject, @email, @code)',
        substitutionValues: {
          'title': title,
          'name': name,
          'subject': subject,
          'email': email,
          'code': code,
        },
      );
      await connection.close();
      print('lo hice bien, guarde los datos');
      return true;
    } catch (e) {
      print("error en $e");
      return false;
    }
  }
}