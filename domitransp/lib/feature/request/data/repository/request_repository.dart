import 'dart:convert';

import 'package:domitransp/core/data/repository/request_list_dto.dart';
import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/repository/chat_dto.dart';
import '../../../global/database.dart';

class NoConection implements Exception {
  String message;

  NoConection({this.message = 'Error de conexión'});
}

class ResponseEmpty implements Exception {
  String message;

  ResponseEmpty(
      {this.message =
          'Adiciona más datos adicionales sobre tu peticiión para que los asesores respondan de manera más eficiente'});
}

class RequestRepository {
  final _baseUrl = Database.host();
  final _puerto = Database.puerto();
  final _nombre_base_datos = Database.databaseName();
  final _usuario = Database.username();
  final _contrasena = Database.password();
  String _created_at = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String _updated_at = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Future<bool> sendResponse(
      {required idRequest, required String message}) async {
    final connection = PostgreSQLConnection(
      _baseUrl,
      _puerto,
      _nombre_base_datos,
      username: _usuario,
      password: _contrasena,
    );
    print('Entre al response');
    try {
      await connection.open();
      final envio = await connection.query(
        'INSERT INTO responses (request_id, content, created_at, updated_at) VALUES (@request_id, @content, @created_at, @updated_at)',
        substitutionValues: {
          'request_id': idRequest,
          'content': message,
          'created_at': _created_at,
          'updated_at': _updated_at
        },
      );
      await connection.close();
      return true;
    } catch (e) {
      print('Falle en el metodo sendReponse, en el RequestRepository: $e');
      throw NoConection();
    }
  }

  Future<List<ChatDto>> getChat({required idRequest}) async {
    final connection = PostgreSQLConnection(
      _baseUrl,
      _puerto,
      _nombre_base_datos,
      username: _usuario,
      password: _contrasena,
    );
    try {
      await connection.open();

      final response = await connection.query(
          'SELECT * FROM responses WHERE request_id = $idRequest ORDER BY id ASC');

      await connection.close();

      List responseList = response.toList();

      print('Lo que trae normalmente la peticion de getchat: $response');
      if (responseList.isNotEmpty) {
        List<ChatDto> getChatList = chatList(response.toList());
        return getChatList;
      } else {
        // throw ResponseEmpty();
        return [];
      }
    } catch (e) {
      print('Falle en el metodo GetChat: $e');
      throw NoConection();
    }
  }

  Future<List<RequestListDto>> validationCode(
      {required SharedPreferences prefs, required List<String> codigos}) async {
    final connection = PostgreSQLConnection(
      _baseUrl,
      _puerto,
      _nombre_base_datos,
      username: _usuario,
      password: _contrasena,
    );
    print('Entre al metodo vlaidation');
    try {
      await connection.open();

      final response = await connection.query('SELECT * FROM requests');

      await connection.close();

      List<RequestListDto> requests = requestList(response.toList());
      print('Esto es requests ');
      List<String> newListCode = [];
      List<RequestListDto> actualRequets = [];
      for (var codigo in codigos) {
        for (var codigoBD in requests) {
          if (codigoBD.code == codigo) {
            newListCode.add(codigoBD.code);
            actualRequets.add(codigoBD);
          }
        }
      }
      print("Esto es actualizado la lista actualizada ${actualRequets}");
      return actualRequets;
    } catch (e) {
      print('Falle en el repositorio: $e y es tipo ${e.runtimeType}');
      throw NoConection();
    }
  }

  bool sendRequest() {
    //codigo para conectar en postgres y enviar solicitud

    return true;
  }

  Future<bool> insertRequest(
      {required String email,
      required String name,
      required String title,
      required String subject,
      required String code}) async {
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
