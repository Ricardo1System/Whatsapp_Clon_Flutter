 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/blocs/contact/contact_bloc.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';
import 'package:whatsapp_clone/widgets/custom_card_contact.dart';
 
 
 class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

 
  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {

late ContactBloc contactBloc;
_SampleItem? selectedMenu;

@override
  void initState() {
    contactBloc=ContactBloc();
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Contactos'),
        actions: [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.search)),
          PopupMenuButton<_SampleItem>(
            initialValue: selectedMenu,
            position: PopupMenuPosition.under,

            onSelected: (_SampleItem item) {
              setState(() {
                selectedMenu = item;
              });
              // switch (item) {
              //   case _SampleItem.itemFive:
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen(),));
              //     break;
              //   default:
              // }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<_SampleItem>>[
              const PopupMenuItem<_SampleItem>(
                value: _SampleItem.itemOne,
                child: Text('Invitar amigos'),
              ),
              const PopupMenuItem<_SampleItem>(
                value: _SampleItem.itemTwo,
                child: Text('Contactos'),
              ),
              const PopupMenuItem<_SampleItem>(
                value: _SampleItem.itemThree,
                child: Text('Actualizar'),
              ),
              const PopupMenuItem<_SampleItem>(
                value: _SampleItem.itemFour,
                child: Text('Ayuda'),
              ),
            ],
          ),
        ],
      ),
       body: BlocListener<ContactBloc, ContactState>(
        bloc:contactBloc ,
        listener: (context, state) {
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          bloc: contactBloc,
          builder: (context, state) {
            return Body(contactList: [
              ContactDto(name: 'Miguel'),
              ContactDto(name: 'Juan'),
              ContactDto(name: 'Raul'),
            ],);
          },
        ),
       )
    );
   }
}



class Body extends StatelessWidget {
  const Body({super.key, required this.contactList});

  final List<ContactDto> contactList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
      children: [
        const Row(
          children: [
            Text('Descubre')
          ],
        ),
        CustomCardContact(contact: ContactDto(name: 'Empresas',isCompany: true))
      ],
    ),
        _ContactList(contactList: contactList),
      ],
    );
  }
}

class _ContactList extends StatelessWidget {
  const _ContactList({
    super.key,
    required this.contactList,
  });

  final List<ContactDto> contactList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text('Contactos')
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: contactList.length,
            itemBuilder:(context, index) => CustomCardContact(contact: contactList[index]), 
            ),
        ),
      ],
    );
  }
}

enum _SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
}