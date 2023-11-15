import 'dart:convert';

List<HomeDto> homeDtoFromJson(String str) => List<HomeDto>.from(json.decode(str).map((x) => HomeDto.fromJson(x)));

String homeDtoToJson(List<HomeDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeDto {
    String url;

    HomeDto({
        required this.url,
    });

    factory HomeDto.fromJson(Map<String, dynamic> json) => HomeDto(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
