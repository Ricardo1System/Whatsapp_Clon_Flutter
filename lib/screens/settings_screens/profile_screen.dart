import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/user/user_dto.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});
  final UserDto user;
  @override
  Widget build(BuildContext context) {
    final appTheme =
        Provider.of<ThemeChange>(context, listen: false).currenttheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      appBar: AppBar(
        title: Row(
          children: [
            Text('Perfil', style: appTheme.textTheme.bodyLarge),
          ],
        ),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(
              tag: user.number,
              child: CircleAvatar(
                backgroundImage: user!.urlImageProfile != ""
                    ? NetworkImage(user!.urlImageProfile)
                    : null,
                backgroundColor: appTheme.colorScheme.primary,
                maxRadius: 80,
                child: user!.urlImageProfile == "" ? const Icon(Icons.person) : null,
              ),
            ),
            SizedBox(height: 20,),
            section(
              icon: Icons.person,
              description: 'Este no es tu nombre de usurio ni un PIN.\nEste nombre será visible para tus contactos de whatsapp',
              text: user.name,
              titule: 'Nombre',
              appTheme: appTheme,
            ),
            section(
              icon: Icons.info_outline,
              text: user.info,
              titule: 'Info',
              appTheme: appTheme,
            ),
            section(
              isEdit: false,
              icon: Icons.call,
              text: user.number,
              titule: 'Numero',
              appTheme: appTheme,
            ),
            // Text(
            //   'Perfil',
            //   style: appTheme.textTheme.bodyMedium!
            //       .copyWith(color: appTheme.colorScheme.surface),
            // )
          ],
        ),
      ),
    );
  }
}

class section extends StatelessWidget {
  const section({
    super.key, required this.appTheme, required this.titule, required this.text, this.description, required this.icon,  this.isEdit=true,
  });

  final ThemeData appTheme;
  final String titule;
  final String text;
  final String? description;
  final IconData icon;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: appTheme.colorScheme.surface,),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titule,
            style: appTheme.textTheme.bodySmall!
                .copyWith(color: appTheme.colorScheme.surface),
          ),
          Row(
            children: [
              Text(
                text,
                style: appTheme.textTheme.bodyMedium!
                    .copyWith(color: appTheme.colorScheme.surface),
              ),
              const Spacer(),
              if(isEdit)
              Icon(Icons.edit,color: appTheme.colorScheme.surface,)
            ],
          ),
          if(description!=null)
          Text(
            description!,
            style: appTheme.textTheme.bodySmall!
                .copyWith(color: appTheme.colorScheme.surface),
          )
        ],
      ),
    );
  }
}
