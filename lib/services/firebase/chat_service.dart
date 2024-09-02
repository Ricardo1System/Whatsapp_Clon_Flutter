

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/screens/chat/model/chat/chat_body_dto.dart';

class ChatService {
  final FirebaseFirestore _firebaseService = FirebaseFirestore.instance;

  Future<ChatBodyDto?> getChatBody(String chatId) async {
    ChatBodyDto? result;
    await _firebaseService.collection("chats").doc(chatId).get().then((value) {
      var data = value.data();
      result = ChatBodyDto.fromJson(data!);
    });
    return result;
  }
}