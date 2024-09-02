import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDto {
  final String? chatId;
  final String name;
  final String? msj;
  final String? time;
  final String? urlImageProfile;
  final bool isCompany;
  final bool isIa;

  ChatDto({
    this.chatId,
    required this.name,
    this.msj,
    this.time,
    this.urlImageProfile,
    this.isIa=false,
    this.isCompany=false,
  });


       // Constructor desde JSON
  factory ChatDto.fromJson(Map<String, dynamic> json) {
    // Convertir el objeto Timestamp a una cadena de texto
    String? formattedDateTime = json["dateTime"] != null? (json["dateTime"] as Timestamp).toDate().toString() : null;

    return ChatDto(
      chatId: json["chatId"],
      name: json["user"] ?? '',
      msj: json["lastMessage"],
      time: formattedDateTime,
      urlImageProfile: json["imageProfile"],
    );
  }

    Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "name": name,
        "msj": msj,
        "dateTime": time,
        "urlImageProfile": urlImageProfile,
    };
    



}