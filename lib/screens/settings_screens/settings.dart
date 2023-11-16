import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/auth/auth_bloc.dart';
import 'package:whatsapp_clone/blocs/user/user_bloc.dart';
import 'package:whatsapp_clone/models/user/user_dto.dart';
import 'package:whatsapp_clone/repositories/user_repository.dart';
import 'package:whatsapp_clone/screens/settings_screens/settings_screens.dart';
import 'package:whatsapp_clone/theme/dark_theme.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late UserBloc userBloc;
  late UserDto user;

  @override 
  void initState() {
    userBloc= UserBloc(userRepository:RepositoryProvider.of<UserRepository>(context));
    userBloc.add(GetInformationProfile());
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context, listen: false).currenttheme;
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Ajustes', style:appTheme.textTheme.bodyMedium),
            
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: BlocListener<UserBloc, UserState>(
        bloc: userBloc,
        listener: (context, state) {
          
        },
        child: BlocBuilder<UserBloc, UserState>(
          bloc: userBloc,
          builder: (context, state) {
            return Center(
              // child: _OptionItem(size: size),
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
                              const CircleAvatar(
                                backgroundImage: null,
                                child: Icon(Icons.person),
                                maxRadius: 30,
                              ),
                              Expanded(
                                child: ListTile(
                                  title: const Text('Ricardo'),
                                  // title: Text(user.name),
                                  subtitle: const Text('Durmiendo',
                                      overflow: TextOverflow.ellipsis, maxLines: 1),
                                  trailing: IconButton(
                                      onPressed: () {}, icon: const Icon(Icons.qr_code)),
                                ),
                              )
                            ],
                          ),
                        ),
                         _ItemOption(
                          title: 'Chat',
                          description: 'Tema, Fondo de pantalla, Historial de chat',
                          icon: const Icon(Icons.message),
                          onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatSettingsScreen(),)),
                         ),
                         _ItemOption(
                          title: 'Cerrar Sesion',
                          icon: const Icon(Icons.exit_to_app_outlined),
                          onTap: () {
                            _logOut();
                           Navigator.pop(context);
                          } 
                         ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ) ,
      )
    );
  }
  
  _logOut() {
    FirebaseAuth.instance.signOut();
  }

}

class _ItemOption extends StatelessWidget {
  const _ItemOption({
    super.key, required this.icon, required this.title, this.description, required this.onTap,
  });

  final Icon icon;
  final String title;
  final String? description;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: const EdgeInsets.symmetric(horizontal:8.0),
     child: SizedBox(
       width: double.infinity,
       child: Row(
         children: [
          Padding(
             padding: const EdgeInsets.all(8.0),
             child: SizedBox(
               width: 30,
               height: 30,
               child: Center(child: icon),
             ),
           ),
           Expanded(
             child: ListTile(
               title: Text(title),
               subtitle: description!=null? Text(description!,
                   overflow: TextOverflow.ellipsis, maxLines: 2):null,
              //  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatSettingsScreen(),)),
               onTap: () => onTap(),
             ),
           )
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
