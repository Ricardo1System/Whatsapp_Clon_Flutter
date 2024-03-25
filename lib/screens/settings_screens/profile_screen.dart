import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/user/user_dto.dart';
import 'package:whatsapp_clone/providers/current_user_provider.dart';
import 'package:whatsapp_clone/screens/camera_screen.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // String fileUrl="";
  

  saveFile(XFile file) async {
    try {
      final currentUserProvider = Provider.of<CurrentUserProvider>(context,listen: false);
      final User? user = FirebaseAuth.instance.currentUser;
      String filePath =
          'uploads/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
      Reference ref = storage.ref().child(filePath);
      await ref.putFile(File(file.path));
      String fileUrl = await ref.getDownloadURL();
      currentUserProvider.updateProfileUrl(fileUrl);
      // setState(() {});
      await firestore.collection('users').doc(user!.uid).update({
        'ImageProfile': fileUrl,
      }).catchError((error) {
        print('Error al actualizar el perfil del usuario: $error');
      });
      print('Archivo cargado con éxito. URL: $fileUrl');
    } catch (e) {
      print('Error al cargar el archivo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme =
        Provider.of<ThemeChange>(context, listen: false).currenttheme;
    final currentUserProvider = Provider.of<CurrentUserProvider>(context,listen: true);
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      appBar: AppBar(
        title: Row(
          children: [
            Text('Perfil', style: appTheme.textTheme.bodyLarge),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: currentUserProvider.loadUserProperties.number,
                  child: CircleAvatar(
                    backgroundImage: currentUserProvider.loadUserProperties.urlImageProfile != ""
                        ? NetworkImage(currentUserProvider.loadUserProperties.urlImageProfile)
                        : null,
                    backgroundColor: appTheme.colorScheme.primary,
                    maxRadius: 80,
                    child: currentUserProvider.loadUserProperties.urlImageProfile == ""
                        ? const Icon(Icons.person)
                        : null,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: ZoomIn(
                    child: InkWell(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: appTheme.colorScheme.primary),
                        child: const Center(
                            child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        )),
                      ),
                      onTap: () async {
                        menuBotom();
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Section(
              icon: Icons.person,
              description:
                  'Este no es tu nombre de usurio ni un PIN.\nEste nombre será visible para tus contactos de whatsapp',
              text: currentUserProvider.loadUserProperties.name,
              titule: 'Nombre',
              appTheme: appTheme,
            ),
            Section(
              icon: Icons.info_outline,
              text: currentUserProvider.loadUserProperties.info,
              titule: 'Info',
              appTheme: appTheme,
            ),
            Section(
              isEdit: false,
              icon: Icons.call,
              text: currentUserProvider.loadUserProperties.number,
              titule: 'Numero',
              appTheme: appTheme,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> menuBotom() {
    final appTheme =
        Provider.of<ThemeChange>(context, listen: false).currenttheme;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 150.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: appTheme.colorScheme.primary,
                  width: 80.w,
                  height: 5.h,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Foto del Perfil',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: appTheme.colorScheme.surface),
                  ),
                  const Icon(Icons.delete)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MultimediaOption(
                    text: 'Cámara',
                    icon: Icons.camera_alt,
                    primaryColor: appTheme.colorScheme.primary,
                    secundaryColor: appTheme.colorScheme.secondary,
                    backgroundColor: appTheme.colorScheme.surface,
                    onTap: () async {
                      var result = await (Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CameraScreen(),
                          )));
                      if (result != null) {
                        saveFile(result);
                      }
                    },
                  ),
                  MultimediaOption(
                    text: 'Galeria',
                    icon: Icons.image,
                    primaryColor: appTheme.colorScheme.primary,
                    secundaryColor: appTheme.colorScheme.secondary,
                    backgroundColor: appTheme.colorScheme.surface,
                    onTap: () {},
                  ),
                  MultimediaOption(
                    text: 'Internet',
                    icon: Icons.download,
                    primaryColor: appTheme.colorScheme.primary,
                    secundaryColor: appTheme.colorScheme.secondary,
                    backgroundColor: appTheme.colorScheme.surface,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class MultimediaOption extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onTap;
  final Color primaryColor;
  final Color secundaryColor;
  final Color backgroundColor;
  const MultimediaOption({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.primaryColor,
    required this.secundaryColor, required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                shape: BoxShape.circle),
            child: Icon(icon),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              text,
              style: TextStyle(color: backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.appTheme,
    required this.titule,
    required this.text,
    this.description,
    required this.icon,
    this.isEdit = true,
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
      leading: Icon(
        icon,
        color: appTheme.colorScheme.surface,
      ),
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
              if (isEdit)
                Icon(
                  Icons.edit,
                  color: appTheme.colorScheme.surface,
                )
            ],
          ),
          if (description != null)
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
