import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/chat/chat_dto.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class CustomCardChat extends StatelessWidget {
  const CustomCardChat({super.key, required this.contact});

  final ChatDto contact;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: SizedBox(
        // color: appTheme.colorScheme.secondary,
        width: double.infinity,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: appTheme.colorScheme.primary,
              backgroundImage: contact.urlImageProfile != null && contact.urlImageProfile != ""
                  ? Image.network(contact.urlImageProfile!,scale: 1.0).image
                  : null,
              maxRadius: 30,
              child: contact.urlImageProfile == null || contact.urlImageProfile == ''
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
