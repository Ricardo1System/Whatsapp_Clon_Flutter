import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class CustomCardContact extends StatelessWidget {
  const CustomCardContact({super.key, required this.contact});

  final ContactDto contact;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        // color: appTheme.colorScheme.secondary,
        width: double.infinity,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: appTheme.colorScheme.primary,
              backgroundImage: contact.image != null
                  ? Image.network(contact.image!).image
                  : null,
              maxRadius: 30,
              child: contact.image == null || contact.image == ''
                  ? !contact.isCompany
                      ? const Icon(Icons.person)
                      : const Icon(Icons.business)
                  : null,
            ),
            Expanded(
              child: ListTile(
                title: Text(contact.name,
                style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface),),
                subtitle: contact.msj != null
                    ? Text(
                        contact.msj!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface) ,
                      )
                    : null,
                trailing: contact.msj != null
                    ? Text(
                        contact.time!,
                        style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface) ,
                      )
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
