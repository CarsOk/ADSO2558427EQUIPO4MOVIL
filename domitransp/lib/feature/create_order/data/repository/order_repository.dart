import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/data/repository/list_order_dto.dart';
import '../../../../core/data/repository/order_dto.dart';
import '../../../global/api.dart';

class OrderError implements Exception {
  String message;

  OrderError({this.message = 'Hubo un error'});
}

class OrderRepository {
  final _url = Api.link();

  Future<List> getOrders() async {
    try {
      String _mockyurl = '';
      Dio _dio = Dio();
      const storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');
      var headers = {'token': token};
      final response = await _dio.get(
        _url + '/orders',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        // response.body;
        // print('Esto es jsonrepsoinse $responseJson');
        final orderData = response.data;
        print('esto es order data: $orderData');
        List<dynamic> orders =
            orderData.map((json) => ListOrderDto.fromJson(json)).toList();
        print('Esto es order ${orders}');
        // return ;
        return orders;
      } else {
        throw OrderError();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(
            'Esto es el tipo de tipo statuscode en error: ${e.response!.statusCode.runtimeType} y es ${e.response!.statusCode}');
        print('Response no es nulo');
        print(e.response);

        if (e.response!.statusCode == 404) {
          throw OrderError(message: 'El codigo es incorrecto');
        } else if (e.response!.statusCode == 422) {
          print('El response es nulo');
          throw OrderError(message: 'Este consecutivo ya existe');
        } else {
          print('El codigo no esperado es: ${e.response!.statusCode}');
          throw OrderError(message: 'Ha ocurrido un error');
        }
      } else {
        throw OrderError(message: 'Error de conexión');
      }
    } catch (e) {
      print('hubo un error: $e');
      throw OrderError();
    }
  }

  Future<bool> createOrder({required OrderDto orden}) async {
    print('entre al metodo create');
    try {
      String _mockyurl = '';
      Dio _dio = Dio();
      const storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');
      var headers = {'token': token};
      final orderJson = orderDtoToJson(orden);
      print('la url es $_url');
      print('asi va el order create: $orderJson');
      final response = await _dio.post(_url + '/orders',
          options: Options(headers: headers), data: orderJson);
      if (response.statusCode == 201) {
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
      print('Se daño el crear orden ${e}');

      if (e.response != null) {
        print(
            'Esto es el tipo de tipo statuscode en error: ${e.response!.statusCode.runtimeType} y es ${e.response!.statusCode}');
        print('Response no es nulo');
        print(e.response);

        if (e.response!.statusCode == 404) {
          throw OrderError(message: 'El codigo es incorrecto');
        } else if (e.response!.statusCode == 422) {
          print('El response es nulo');
          throw OrderError(message: 'Este consecutivo ya existe');
        } else {
          print('El codigo no esperado es: ${e.response!.statusCode}');
          throw OrderError(message: 'Ha ocurrido un error');
        }
      } else {
        throw OrderError(message: 'Error de conexión');
      }
    } catch (e) {
      throw OrderError();
    }
  }
}
