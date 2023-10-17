
class ChatDto {
  String id;
  String content;
  String request_id;
  DateTime created_at;
  DateTime updated_at;
  String rol;

  ChatDto({
    required this.id,
    required this.content,
    required this.request_id,
    required this.created_at,
    required this.updated_at,
    required this.rol,
  });
}

List<ChatDto> chatList(List responsePostgres){
    List<ChatDto> chatList = [];

    for (var row in responsePostgres) {
      ChatDto chat = ChatDto(
        id: row[0].toString(),
        content: row[1].toString() ?? "",
        request_id: row[2].toString() ?? "",
        created_at: DateTime.tryParse(row[3].toString()) ?? DateTime.now(),
        updated_at: DateTime.tryParse(row[4].toString()) ?? DateTime.now(),
        rol: row[5].toString() ?? "U"
      );

      chatList.add(chat);
    }

    print('Lo que retorna chatDto: $chatList');
    return chatList;
  }