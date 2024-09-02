

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.contact,
  });

  final ContactDto contact;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return CircleAvatar(
      backgroundColor: appTheme.colorScheme.primary,
      backgroundImage: contact.imageProfile != ""
          ? Image.network(contact.imageProfile ,scale: 1.0).image
          : null,
      maxRadius: 30,
      child:  contact.imageProfile == ''
          ?  const Icon(Icons.person)
          : null,
    );
  }
}