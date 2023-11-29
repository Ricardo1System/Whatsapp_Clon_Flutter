import 'package:meta/meta.dart';
import 'dart:convert';

class UserDto {
    int? id;
    String name;
    String urlImageProfile;
    String info;
    String number;

    UserDto({
        this.id,
        required this.name,
        required this.info,
        required this.number,
        required this.urlImageProfile,
    });

    factory UserDto.fromRawJson(String str) => UserDto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json["Id"],
        name: json["Name"],
        info: json["Info"],
        number: json["Number"],
        urlImageProfile: json["ImageProfile"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "info": info,
        "number": number,
        "urlImageProfile": urlImageProfile,
    };
}
