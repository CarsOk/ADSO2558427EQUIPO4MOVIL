
import 'package:intl/intl.dart';
import 'package:postgres/postgres.dart';

// RequestListDto requestListDtoFromPostgres(PostgreSQLResult post) => RequestListDto.tolista(post);

// class RequestListDto{
//   List<dynamic> listcode;

//   RequestListDto({
//     required this.listcode
//   });

//   factory RequestListDto.tolista(PostgreSQLResult post) {
//     return RequestListDto(listcode: post.map<dynamic>((row) => row[0]).toList());
//   }
// }

// To parse this JSON data, do
//
//     final requestList = requestListFromJson(jsonString);

// To parse this JSON data, do
//
//     final requestListDto = requestListDtoFromJson(jsonString);


class RequestListDto{
  String id;
  String title;
  String name;
  String subject;
  String email;
  String code;
  DateTime createdAt;
  DateTime updatedAt;
  String estado;

  RequestListDto({
    required this.id,
    required this.title,
    required this.name,
    required this.subject,
    required this.email,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.estado,
    });

}

List<RequestListDto> requestList(List responsePostgres){
  List<RequestListDto> requestList = [];

    for (var row in responsePostgres) {

      RequestListDto request = RequestListDto(
        id: row[0].toString(),
        title: row[1].toString(),
        name: row[2]?.toString() ?? "",
        subject: row[3]?.toString() ?? "",
        email: row[4]?.toString() ?? "",
        code: row[5]?.toString() ?? "",
        createdAt: DateTime.tryParse(row[6].toString()) ?? DateTime.now(),
        updatedAt: DateTime.tryParse(row[7].toString()) ?? DateTime.now(),
        estado: row[8]?.toString() ?? "",
      );

      requestList.add(request);
    }
  return requestList;
} 