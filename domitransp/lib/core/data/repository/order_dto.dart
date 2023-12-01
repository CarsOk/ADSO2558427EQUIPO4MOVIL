import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';

OrderDto orderDtoFromJson(String str) => OrderDto.fromJson(json.decode(str));

String orderDtoToJson(OrderDto data) => json.encode(data.toJson());

class OrderDto {
  String fecha;
  int consecutivo;
  String avatar;
  String destino;
  String origen;
  String estado;
  List<PackAttribute> packAttributes;

  OrderDto({
    required this.fecha,
    required this.consecutivo,
    required this.avatar,
    required this.destino,
    required this.origen,
    required this.estado,
    required this.packAttributes,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) => OrderDto(
        fecha: json["fecha"],
        consecutivo: json["consecutivo"],
        avatar: json["avatar"],
        destino: json["destino"],
        origen: json["origen"],
        estado: json["estado"],
        packAttributes: List<PackAttribute>.from(
            json["packs_attributes"].map((x) => PackAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fecha": formattedFecha(fecha),
        "consecutivo": consecutivo,
        "avatar": avatar,
        "destino": destino,
        "origen": origen,
        "estado": estado,
        "packs_attributes":
            List<dynamic>.from(packAttributes.map((x) => x.toJson())),
      };

  String formattedFecha(fecha) {
    DateTime parsedFecha = DateTime.tryParse(fecha) ?? DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSSSSS Z').format(parsedFecha);
  }

  void convertirImagenABase64(String pathToImage) {
    List<int> imageBytes = File(pathToImage).readAsBytesSync();
    avatar = base64Encode(imageBytes);
  }
}

class PackAttribute {
  String tipo;
  int cantidad;

  PackAttribute({
    required this.tipo,
    required this.cantidad,
  });

  factory PackAttribute.fromJson(Map<String, dynamic> json) => PackAttribute(
        tipo: json["tipo"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "tipo": tipo,
        "cantidad": cantidad,
      };
}
