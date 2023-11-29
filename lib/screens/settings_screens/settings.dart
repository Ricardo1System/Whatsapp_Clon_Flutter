import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/user/user_bloc.dart';
import 'package:whatsapp_clone/models/user/user_dto.dart';
import 'package:whatsapp_clone/repositories/user_repository.dart';
import 'package:whatsapp_clone/screens/settings_screens/profile_screen.dart';
import 'package:whatsapp_clone/screens/settings_screens/settings_screens.dart';
import 'package:whatsapp_clone/theme/theme.dart';
import 'package:whatsapp_clone/utils/common_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserBloc? userBloc;
  UserDto? user;

  @override
  void initState() {
    userBloc = UserBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context));
    userBloc!.add(GetProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme =
        Provider.of<ThemeChange>(context, listen: true).currenttheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: appTheme.colorScheme.background,
        appBar: AppBar(
          title: Row(
            children: [
              Text('Ajustes', style: appTheme.textTheme.bodyLarge),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: BlocListener<UserBloc, UserState>(
          bloc: userBloc,
          listener: (context, state) {
            if (state is GetInformationLoading) {
              showProgress(context);
            }
            if (state is GetInformationLoaded) {
              hideProgress(context);
              setState(() {
                user = state.user;
              });
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            bloc: userBloc,
            builder: (context, state) {
              if (user != null) {
                return Center(
                  // child: _OptionItem(size: size),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(user:user!) ,) );
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Hero(
                                      tag: user!.number,
                                      child: CircleAvatar(
                                        backgroundImage: user!.urlImageProfile!=""? NetworkImage( user!.urlImageProfile ) : null,
                                        backgroundColor:
                                            appTheme.colorScheme.primary,
                                        maxRadius: 30,
                                        child: user!.urlImageProfile==""? Icon(Icons.person) : null,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          '${user!.name}',
                                          style: appTheme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: appTheme
                                                      .colorScheme.surface),
                                        ),
                                        // title: Text(user.name),
                                        subtitle: Text('${user!.info}',
                                            style: appTheme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: appTheme
                                                        .colorScheme.surface),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1),
                                        trailing: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.qr_code,
                                              color: appTheme.colorScheme.surface,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            _ItemOption(
                              title: 'Chat',
                              description:
                                  'Tema, Fondo de pantalla, Historial de chat',
                              icon: Icon(
                                Icons.message,
                                color: appTheme.colorScheme.surface,
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChatSettingsScreen(),
                                  )),
                            ),
                            _ItemOption(
                                title: 'Cerrar Sesion',
                                icon: Icon(
                                  Icons.exit_to_app_outlined,
                                  color: appTheme.colorScheme.surface,
                                ),
                                onTap: () {
                                  _logOut();
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ));
  }

  _logOut() {
    FirebaseAuth.instance.signOut();
  }
}

class _ItemOption extends StatelessWidget {
  const _ItemOption({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    required this.onTap,
  });

  final Icon icon;
  final String title;
  final String? description;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final appTheme =
        Provider.of<ThemeChange>(context, listen: false).currenttheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: icon,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(title,
                    style: appTheme.textTheme.bodyMedium!
                        .copyWith(color: appTheme.colorScheme.surface)),
                subtitle: description != null
                    ? Text(description!,
                        style: appTheme.textTheme.bodyMedium!
                            .copyWith(color: appTheme.colorScheme.surface),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2)
                    : null,
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


