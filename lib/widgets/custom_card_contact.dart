import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';

class CustomCardContact extends StatelessWidget {
  const CustomCardContact({super.key, required this.contact});

  final ContactDto contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 3.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:contact.image!=null? Image.network(contact.image!).image:null,
              maxRadius: 30,
              child: contact.image == null || contact.image == '' ?  !contact.isCompany? const Icon(Icons.person):const Icon(Icons.business):null,
            ),
            Expanded(
              child: ListTile(
                title: Text(contact.name),
                subtitle: contact.msj!=null? Text(contact.msj!,overflow: TextOverflow.ellipsis, maxLines: 1):null,
                trailing: contact.msj!=null? Text(contact.time!):null,
              ),
            )
          ],
        ),
      ),
    );
  }
}