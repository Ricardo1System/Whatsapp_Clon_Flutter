import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/chat/chat_bloc.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';
import 'package:whatsapp_clone/screens/contacts_screens/chat_ia_screen.dart';
import 'package:whatsapp_clone/screens/contacts_screens/contacts_list.dart';
import 'package:whatsapp_clone/theme/theme.dart';
import 'package:whatsapp_clone/widgets/custom_card_contact.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatBloc _chatBloc=ChatBloc();
  List<ContactDto> chatList=[
    ContactDto(
        msj: '',
        name: 'Chat IA YesNo',
        time: '',
        urlImageProfile: '',
        isIa: true,
      ),
  ];


  @override
  void initState() {
    _chatBloc.add(GetChatsHome());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    final appTheme=Provider.of<ThemeChange>(context).currenttheme;
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      floatingActionButton: FloatingActionButton(onPressed: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ContactListPage(),));
      },
      child: const Icon(Icons.chat),
      ),
      body: BlocListener<ChatBloc, ChatState>(
        bloc: _chatBloc,
        listener: (context, state) {
          if (state is GetChatsLoaded) {
            setState(() {
            chatList.addAll(state.contactChats);
            });
          }
        },
        child: _bodyChatList(chatList: chatList),
      ),
    );
  }
}

class _bodyChatList extends StatelessWidget {
  const _bodyChatList({
    super.key,
    required this.chatList,
  });

  final List<ContactDto> chatList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatIAScreen(),)),
            child: FadeInUp(
              // duration: Duration(seconds: 1),
              // from: 0.0,
              delay: Duration(milliseconds: 50*(1+index)),
              child: CustomCardContact(contact:chatList[index])));
        },
      ),
    );
  }
}




