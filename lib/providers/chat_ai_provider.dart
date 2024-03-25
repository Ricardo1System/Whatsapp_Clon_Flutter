import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/contacts_screens/chat_ia_screen.dart';

class ChatAIProvider extends ChangeNotifier {
  final ScrollController chatScrollcontroller = ScrollController();
  final GetYesNotAnswer getYesNotAnswer=GetYesNotAnswer();

  List<Message> messageList = [
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty)return;
    final msj = Message(fromWho: FromWho.me, text: text);
    messageList.add(msj);

    if (text.endsWith('?')) {
      await herReply();
    }
    notifyListeners();
    moveScrollToBotton();
  }

  Future<void> moveScrollToBotton()async {
    Future.delayed(const Duration(milliseconds: 300));
    chatScrollcontroller.animateTo(
      chatScrollcontroller.position.maxScrollExtent,
      duration: const Duration(milliseconds:300 ),
      curve: Curves.easeOut,
    );
  }

  Future<void> herReply ()async{
    try {
      final herMessage = await getYesNotAnswer.getAnswer();
    messageList.add(herMessage);
    moveScrollToBotton();
      notifyListeners();
    } catch (e) {
      messageList.add(Message(text: e.toString(), fromWho: FromWho.me));
    }
    
  }
}