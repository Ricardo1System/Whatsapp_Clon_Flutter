

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/blocs/chat/chat_bloc.dart';

class ViewChatBody extends StatefulWidget {

  final String chatId;

  const ViewChatBody({
    super.key, required this.chatId,
  });

  @override
  State<ViewChatBody> createState() => _ViewChatBodyState();
}

class _ViewChatBodyState extends State<ViewChatBody> {

  late ChatBloc chatBloc;

  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(GetChatBody(chatId: widget.chatId));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("Hola");
  }
}