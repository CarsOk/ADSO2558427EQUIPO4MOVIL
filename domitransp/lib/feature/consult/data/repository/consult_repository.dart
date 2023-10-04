import 'dart:convert';
import 'package:postgres/postgres.dart';

import '../../../../core/data/repository/consult_dto.dart';

class Nocode implements Exception{
  String message;

  Nocode({this.message = 'No se encontro codigo'});
}

class ConsultRepository {
  final _baseUrl = 'b5xn4aiw71dpvzecdgzw-postgresql.services.clever-cloud.com';
  final _puerto = 5432;
  final _nombre_base_datos = 'b5xn4aiw71dpvzecdgzw';
  final _usuario = 'u11nk76ov6hufjlqcdvy';
  final _contrasena = 'qESlbEQ5OahuAKZkrhXYjgcNhmoO50';

  Future <ConsultaDto> buscarRegistro(String codigo) async {
    
    try {
      final connection = PostgreSQLConnection(
        _baseUrl,
        _puerto,
        _nombre_base_datos,
        username: _usuario,
        password: _contrasena,
      );

      await connection.open();

      final results = await connection.query(
        'SELECT origen, destino, estado FROM orders WHERE codigo_envio = @codigo',
        substitutionValues: {'codigo': codigo},
      );

      print("LO QUE TRAE RESULTS"); 
      print(results);

      print("LO QUE RETORNA");
      print(results.map((row) => row.toColumnMap()).toList());
      print(results.map((row) => row.toColumnMap()).toList().runtimeType);

      await connection.close();

      final resultadoJhon = results.map((row) => row.toColumnMap()).toList().first;

      print("Jhon");

      print(resultadoJhon);

      print(resultadoJhon);

      final consultDto = consultaDtoFromJson(json.encode(results.map((row) => row.toColumnMap()).toList().first).toString());
      return consultDto;
    } catch (e) {
      print("Chale falle en envio de codigo");
      print(e);
      throw Nocode(message: 'No se encontro envio');
    }
    
  }
}