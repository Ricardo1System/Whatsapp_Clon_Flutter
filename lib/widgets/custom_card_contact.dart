import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';
import 'package:whatsapp_clone/theme/theme.dart';
import 'package:whatsapp_clone/widgets/custom_circle_avatar.dart';

class CustomCardContact extends StatelessWidget {
  const CustomCardContact({super.key, required this.contact});

  final ContactDto contact;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            CustomCircleAvatar(contact: contact),
            Expanded(
              child: ListTile(
                title: Text(contact.name,
                style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface),),
              ),
            )
          ],
        ),
      ),
    );
  }
}


