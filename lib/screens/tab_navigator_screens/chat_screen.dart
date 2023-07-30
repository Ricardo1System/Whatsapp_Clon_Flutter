import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatListDto> chatList=[
      ChatListDto(
        msj: 'Hola prro, te andan buscando los federales',
        name: 'Miguel Armando Lorenzo',
        time: '12:00',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRthj1N4v-edrUYVJQPM7OjCjdoJI4zCvMPMQ&usqp=CAU'
      )
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },
      child: const Icon(Icons.chat),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: chatList.length+1,
          itemBuilder: (context, index) {
            return CustomCard(chat:chatList[0]);
          },
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chat});

  final ChatListDto chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 3.0),
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: Image.network(chat.image!).image,
              maxRadius: 30,
            ),
            Expanded(
              child: ListTile(
                title: Text(chat.name),
                subtitle: Text(chat.msj,overflow: TextOverflow.ellipsis, maxLines: 1),
                trailing: Text(chat.time),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatListDto {
  final String? image;
  final String name;
  final String msj;
  final String time;

  ChatListDto({
    this.image,
    required this.name,
    required this.msj,
    required this.time,
  });
}
