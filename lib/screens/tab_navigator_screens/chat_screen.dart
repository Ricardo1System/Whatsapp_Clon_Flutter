import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';
import 'package:whatsapp_clone/screens/contacts_screens/chat_ia_screen.dart';
import 'package:whatsapp_clone/screens/contacts_screens/contacts_list.dart';
import 'package:whatsapp_clone/widgets/custom_card_contact.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ContactDto> chatList=[
      ContactDto(
        msj: '',
        name: 'Chat IA YesNo',
        time: '',
        image: '',
        isIa: true,
      ),
      ContactDto(
        msj: 'Hola prro, te andan buscando los federales',
        name: 'Miguel Armando Lorenzo',
        time: '12:00',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRthj1N4v-edrUYVJQPM7OjCjdoJI4zCvMPMQ&usqp=CAU'
      )
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactListPage(),));
      },
      child: const Icon(Icons.chat),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatIAScreen(),)),
              child: CustomCardContact(contact:chatList[index]));
          },
        ),
      ),
    );
  }
}




