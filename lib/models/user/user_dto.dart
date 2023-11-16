import 'package:meta/meta.dart';
import 'dart:convert';

class UserDto {
    int id;
    String name;
    String lastName;
    String urlImageProfile;
    String info;

    UserDto({
        required this.id,
        required this.name,
        required this.lastName,
        required this.urlImageProfile,
        required this.info,
    });

    factory UserDto.fromRawJson(String str) => UserDto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        urlImageProfile: json["urlImageProfile"],
        info: json["info"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "urlImageProfile": urlImageProfile,
        "info": info,
    };
}
