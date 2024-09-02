

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User _user = FirebaseAuth.instance.currentUser!;

class ChatBodyDto {
  final List<MessageDto> messageList;

  ChatBodyDto({required this.messageList});

  factory ChatBodyDto.fromJson(Map<String,dynamic> json){
    return ChatBodyDto(messageList: (json["Messages"] as List).map((item) => MessageDto.fromJson(item)).toList());
  }
}


class MessageDto {
  final String dateTime;
  final String msj;
  final bool sendMe;

  MessageDto({required this.dateTime, required this.msj, required this.sendMe});

  factory MessageDto.fromJson(Map<String, dynamic> json){
    String formattedDateTime = (json["dateTime"] as Timestamp).toDate().toString();
    return MessageDto(
      dateTime: formattedDateTime,
      msj:json["msj"],
      sendMe: _user.uid == json["send"],
    );
  }
}