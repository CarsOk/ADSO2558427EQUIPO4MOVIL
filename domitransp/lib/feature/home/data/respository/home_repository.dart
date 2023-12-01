import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/data/repository/home_dto.dart';

class ErrorHome implements Exception {
  String message;

  ErrorHome({this.message = 'Ha ocurrido un error'});
}

class HomeRepository {
  Future<List<HomeDto>> bannerPromocion() async {
    try {
      print('ente el metodo de publicidad');
      final _mockyUrl =
          'https://run.mocky.io/v3/1f0f30d4-ac8a-48da-8ed7-427e822f915c';
      Dio _dio = Dio();
      Dio _dioP = Dio();
      print('instancia dio');
      final response = await _dio.get(_mockyUrl);
      print('se envia peticion');

      if (response.statusCode == 200) {
        print('larespuestas fue 200');
        String responseData = json.encode(response.data);
        print(
            'Esto es data: ${responseData} y es tipo: ${responseData.runtimeType}');
        final publications = homeDtoFromJson(responseData);
        print('esto es la listas convertida $publications');
        publications.forEach((publication) {
          // ignore: unused_local_variable
          print('Esta es la publicacion ${publication.url}');
          final response = _dioP.get(publication.url);
        });
        return publications;
      } else {
        print('error en la peticion de Dio posters');
        throw ErrorHome;
      }
    } on DioError catch (e) {
      print('esto es tipo error e: ${e.runtimeType}');
      // if (e is DioError) {
      //   print('Entre al error de tipo dio');
      //   print(e.response!.statusCode);
      //   print(e.message);
      //   print(e.response);
      //   throw ErrorHome();
      // }
      // print(e.runtimeType);
      // print('Se daño el confirmar user ${e}');

      if (e.response != null) {
        print(
            'Esto es el tipo de tipo statuscode en error: ${e.response!.statusCode.runtimeType} y es ${e.response!.statusCode}');
        print('Response no es nulo');
        print(e.response);

        if (e.response!.statusCode == 404) {
          throw ErrorHome(message: 'No se encontro información');
        } else {
          print('no es 404');
          throw ErrorHome();
        }
      } else {
        print('El response es nulo');
        throw ErrorHome(message: 'Error de conexión');
      }
      throw ErrorHome(message: 'Error de conexión');
    } catch (e) {
      print('Error inesperado posters; ${e} tipo ${e.runtimeType}');
      throw ErrorHome();
    }
  }
}
