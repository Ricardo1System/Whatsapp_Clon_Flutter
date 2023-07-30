import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/settings_screens/settings_screens.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDto user=const UserDto(
      image: 'https://www.semana.com/resizer/Gfii8CYJWKxrDK1wwjzUS2YfpKA=/1280x720/smart/filters:format(jpg):quality(80)/cloudfront-us-east-1.images.arcpublishing.com/semana/IWX37TVU7RCRDEAB3JBLFJHFZA.jpg',
      info: 'Cenando',
      name: 'Ricardo',
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: Image.network(user.image).image,
                          maxRadius: 30,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(user.name),
                            subtitle: Text(user.info,
                                overflow: TextOverflow.ellipsis, maxLines: 1),
                            trailing: IconButton(
                                onPressed: () {}, icon: const Icon(Icons.qr_code)),
                          ),
                        )
                      ],
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Center(child: Icon(Icons.chat)),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('Chat'),
                              subtitle: const Text('Tema, fondos de pantalla, historial de chat',
                                  overflow: TextOverflow.ellipsis, maxLines: 2),
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatSettingsScreen(),)),
                              
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDto {
  final String image;
  final String name;
  final String info;

  const UserDto({
    required this.image,
    required this.name,
    required this.info,
  });
}
