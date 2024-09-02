import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';
import 'package:whatsapp_clone/models/widgets/pop_menu_item_data.dart';
import 'package:whatsapp_clone/screens/chat/view_chat_body.dart';
import 'package:whatsapp_clone/screens/chat/widgets/view_chat_controller.dart';
import 'package:whatsapp_clone/theme/theme.dart';
import 'package:whatsapp_clone/widgets/custom_circle_avatar.dart';
import 'package:whatsapp_clone/widgets/custom_popup_menu_button.dart';

class ViewChatScreen extends StatelessWidget {
  final String chatId;
  const ViewChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    final itemDataList = <PopupMenuItemData<_SampleItem>>[
      PopupMenuItemData(value: _SampleItem.itemOne, child: "Ver contacto"),
      PopupMenuItemData(
          value: _SampleItem.itemTwo, child: "Archivos, enlaces y documentos"),
      PopupMenuItemData(value: _SampleItem.itemThree, child: "Buscar"),
      PopupMenuItemData(
          value: _SampleItem.itemFour, child: "Mensajes temporales"),
      PopupMenuItemData(
          value: _SampleItem.itemFive, child: "Fondo de pantalla"),
      PopupMenuItemData(value: _SampleItem.itemSix, child: "Más"),
    ];
    ContactDto contact = ContactDto(
        name: "Miguel",
        number: '2871107482',
        info: 'En el gym',
        imageProfile: '');

    void onSelected(_SampleItem item) {
      switch (item) {
        case _SampleItem.itemFive:
          break;
        default:
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCircleAvatar(contact: contact),
            Text(contact.name),
            const Expanded(
              child: SizedBox(
              ),
            ),
            IconButton(onPressed: () {
              
            }, icon: const Icon(Icons.video_camera_front_outlined)),
            IconButton(onPressed: () {
              
            }, icon: const Icon(Icons.call_outlined)),
            CustomPopuoMenuButton(
              initialValue: null,
              itemBuilder: () => List.generate(
                  itemDataList.length,
                  (index) => PopupMenuItem<_SampleItem>(
                        value: itemDataList[index].value,
                        child: Text(
                          itemDataList[index].child,
                          style: appTheme.textTheme.bodyMedium!
                              .copyWith(color: appTheme.colorScheme.surface),
                        ),
                      )),
              onSelected: (value) => onSelected(value!),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ViewChatBody(chatId: chatId),
          ),
          const ViewChatController()
        ],
      ),
    );
  }
}





enum _SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
  itemFive,
  itemSix,
}
