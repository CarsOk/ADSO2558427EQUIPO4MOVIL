import 'dart:convert';
import 'dart:io';

OrderDto orderDtoFromJson(String str) => OrderDto.fromJson(json.decode(str));

String orderDtoToJson(OrderDto data) => json.encode(data.toJson());

class OrderDto {
  String fecha;
  int consecutivo;
  String avatar; // Ahora será una cadena Base64
  String destino;
  String origen;
  String estado;
  int valor;
  List<PackAttribute> packAttributes;

  OrderDto({
    required this.fecha,
    required this.consecutivo,
    required this.avatar,
    required this.destino,
    required this.origen,
    required this.estado,
    required this.valor,
    required this.packAttributes,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) => OrderDto(
        fecha: DateTime.parse(json["fecha"]),
        consecutivo: json["consecutivo"],
        avatar: json["avatar"],
        destino: json["destino"],
        origen: json["origen"],
        estado: json["estado"],
        valor: json["valor"],
        packAttributes: List<PackAttribute>.from(
            json["pack_attributes"].map((x) => PackAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "consecutivo": consecutivo,
        "avatar": avatar,
        "destino": destino,
        "origen": origen,
        "estado": estado,
        "valor": valor,
        "pack_attributes": List<dynamic>.from(
            packAttributes.map((x) => x.toJson())),
      };

  // Agregar un método para convertir la imagen a Base64
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
