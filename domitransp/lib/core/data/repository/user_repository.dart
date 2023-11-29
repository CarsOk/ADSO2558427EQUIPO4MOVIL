import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:domitransp/core/data/repository/user_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../feature/global/api.dart';

class UserError {
  final storageToken = FlutterSecureStorage();
  String message;

  UserError({this.message = 'Ha ocurrido un error'});
}

class UserRepository {
  // ignore: prefer_const_constructors
  final storageToken = FlutterSecureStorage();
  final _url = Api.link();
  Future<bool> getToken() async {
    print('Entre al repository');
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token != null) {
      print('tiene usuario');
      return true;
    } else {
      print('No tiene usuario');
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'token');
      return true;
    } catch (e) {
      throw UserError();
    }
  }

  Future<UserDto> getUser() async {
    try {
      Dio _dio = Dio();
      final storage = new FlutterSecureStorage();
      final token = await storage.read(key: 'token');
      var headers = {'token': token};
      print('Este es el header ${headers}');
      final response = await _dio.get('$_url/users/show',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        print('Este es la data: ${response.data}');
        final user = UserDto.fromJson(response.data);
        print('Get user se hizo bien');
        return user;
      } else {
        throw UserError();
      }
    } catch (e) {
      print('Falle en repositorio, en obtener usuario: $e');

      throw UserError();
    }
  }

  Future<bool> userSignIn({required String email}) async {
    Dio _dio = Dio();
    try {
      print('Entre al sign_in');
      final response = await _dio.post(
        '$_url/users/sign_in',
        data: json.encode({"email": email}),
      );
      print('Ya hice la peticion');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('esto es tipo error e: ${e.runtimeType}');
      // if (e is DioError) {
      //   print('Entre al error de tipo dio');
      //   print(e.response!.statusCode);
      //   print(e.message);
      //   print(e.response);
      //   throw NoCodeState();
      // }
      print(e.runtimeType);
      print('Se daño el confirmar user ${e}');

      if (e.response != null) {
        print(
            'Esto es el tipo de tipo statuscode en error: ${e.response!.statusCode.runtimeType} y es ${e.response!.statusCode}');
        print('Response no es nulo');
        print(e.response);

        if (e.response!.statusCode == 404) {
          throw UserError(message: 'Ingreso usuario incorrecto');
        } else if (e.response!.statusCode == 500) {
          throw UserError(message: 'Error del servidor');
        } else {
          throw UserError();
        }
      } else {
        print('El response es nulo');
        throw UserError(message: 'Error de conexión');
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> authentication() async {
    final token = storageToken.read(key: 'token');

    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> confirmarUser(
      {required String email, required String code}) async {
    try {
      print('Entre al confirmar user');
      print("LO QUE LLEGA AL CONFIRMAR USER");
      print(email);
      print(code);
      final Dio _dio = Dio();
      final response = await _dio.post(_url + '/users/confirmation',
          data: jsonEncode({"code": code, "email": email}));
      print("Esto es response");
      print(response.toString());
      print(response.runtimeType);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final String token = responseData['token'];
        await storageToken.write(key: 'token', value: token);
        return true;
      } else {
        print(
            'Entre al primer error: el status code fue de ${response.statusCode}');

        throw UserError();
      }
    } on DioError catch (e) {
      print('esto es tipo error e: ${e.runtimeType}');
      // if (e is DioError) {
      //   print('Entre al error de tipo dio');
      //   print(e.response!.statusCode);
      //   print(e.message);
      //   print(e.response);
      //   throw NoCodeState();
      // }
      print(e.runtimeType);
      print('Se daño el confirmar user ${e}');

      if (e.response != null) {
        print(
            'Esto es el tipo de tipo statuscode en error: ${e.response!.statusCode.runtimeType} y es ${e.response!.statusCode}');
        print('Response no es nulo');
        print(e.response);

        if (e.response!.statusCode == 404) {
          throw UserError(message: 'El codigo es incorrecto');
        } else {
          print('no es 404');
          throw UserError(message: 'Codigo no valido');
        }
      } else {
        print('El response es nulo');
        throw UserError(message: 'Error de conexión');
      }
    } catch (e) {
      throw UserError();
    }
  }
}
