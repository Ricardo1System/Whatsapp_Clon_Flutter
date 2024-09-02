 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/contact/contact_bloc.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';
import 'package:whatsapp_clone/theme/theme.dart';
import 'package:whatsapp_clone/widgets/custom_card_contact.dart';
 
 
 class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

 
  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {

late ContactBloc contactBloc;
List<ContactDto> contactList = [];
_SampleItem? selectedMenu;

@override
  void initState() {
    contactBloc = BlocProvider.of<ContactBloc>(context);
    contactBloc.add(GetContactsEvent());
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
     final appTheme=Provider.of<ThemeChange>(context).currenttheme;
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Contactos'),
        actions: [
          IconButton(onPressed: () {
            
          }, icon: const Icon(Icons.search)),
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
          if (state is GetContactsLoaded) {
            contactList = state.userList;
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          bloc: contactBloc,
          builder: (context, state) {
            return Body(contactList: contactList,);
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Column(
            children: [
              CardActionContact(
                text: "Nuevo grupo",
                icon1: Icons.people,
              ),
              CardActionContact(
                text: "Nuevo contacto",
                icon1: Icons.person_add_alt_sharp,
                icon2: Icons.qr_code,
              ),
              CardActionContact(
                text: "Nueva comunidad",
                icon1: Icons.emoji_people,
              ),
            ],
          ),
          Expanded(child: _ContactList(contactList: contactList)),
        ],
      ),
    );
  }
}

class CardActionContact extends StatelessWidget {
  const CardActionContact({
    super.key, required this.text, required this.icon1, this.icon2,
  });

  final String text;
  final IconData icon1;
  final IconData? icon2;

  @override
  Widget build(BuildContext context) {
     final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return ListTile(
      title: Text(text, style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.surface),),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: appTheme.colorScheme.primary,
          shape: BoxShape.circle
        ),
        child: Center(
          child: Icon(icon1, color: appTheme.colorScheme.background , size: 25),
        ),
      ),
      trailing: icon2 != null ? Icon(icon2, color: appTheme.colorScheme.primary,) : null,
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Contactos'),
            )
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