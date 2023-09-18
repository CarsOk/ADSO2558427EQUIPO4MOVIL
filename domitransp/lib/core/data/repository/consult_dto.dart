import 'dart:convert';

ConsultaDto consultaDtoFromJson(String str) => ConsultaDto.fromJson(json.decode(str));

class ConsultaDto {
    String origen;
    String destino;
    String estado;

    ConsultaDto({
        required this.origen,
        required this.destino,
        required this.estado,
    });

    factory ConsultaDto.fromJson(Map<String, dynamic> json) => ConsultaDto(
        origen: json["origen"],
        destino: json["destino"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "origen": origen,
        "destino": destino,
        "estado": estado,
    };
}