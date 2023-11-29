import 'dart:convert';

import 'package:intl/intl.dart';

UserDto userDtoFromJson(String str) => UserDto.fromJson(json.decode(str));

// String userDtoToJson(UserDto data) => json.encode(data.toJson());

class UserDto {
  int? id;
  String email;
  int? companyId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String nombre;
  String? apellido;
  bool? admin;
  String? avatar;

  UserDto({
    required this.id,
    required this.email,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.nombre,
    required this.apellido,
    required this.admin,
    required this.avatar,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json.containsKey('id') ? json["id"] : null,
        email: json.containsKey('email') ? json["email"] : null,
        companyId: json.containsKey('company_id') ? json["company_id"] : null,
        createdAt: DateTime.tryParse(json["created_at"].toString()),
        updatedAt: DateTime.tryParse(json["updated_at"].toString()),
        nombre: json["nombre"],
        apellido: json["apellido"],
        admin: json["admin"],
        avatar: json["avatar"],
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "email": email,
  //       "company_id": companyId,
  //       "created_at": createdAt.toIso8601String(),
  //       "updated_at": updatedAt.toIso8601String(),
  //       "nombre": nombre,
  //       "apellido": apellido,
  //       "admin": admin,
  //       "avatar": avatar,
  //     };
}
