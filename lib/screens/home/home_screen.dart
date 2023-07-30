import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/screen.dart';
import 'package:whatsapp_clone/screens/settings_screens/settings_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SampleItem? selectedMenu;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whatsapp Clone'),
        bottom: TabBar(controller: _tabController, tabs: const <Widget>[
          Tab(icon: Icon(Icons.people_alt)),
          Tab(
            text: 'Chats',
          ),
          Tab(
            text: 'Estados',
          ),
          Tab(
            text: 'Llamadas',
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          // IconButton(onPressed: () {
          //   // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(),) );
          // }, icon: const Icon(Icons.more_vert_rounded)),
          PopupMenuButton<SampleItem>(
            initialValue: selectedMenu,
            position: PopupMenuPosition.under,

            onSelected: (SampleItem item) {
              setState(() {
                selectedMenu = item;
              });
              switch (item) {
                case SampleItem.itemFive:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen(),));
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemOne,
                child: Text('Nuevo grupo'),
              ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: Text('Nueva difusión'),
              ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemThree,
                child: Text('Dispositivos vinculados'),
              ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemFour,
                child: Text('Mensajes destacados'),
              ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemFive,
                child: Text('Ajustes'),
                 
              ),
            ],
          ),
        ],
      ),
      // bottomNavigationBar: ,
      body: TabBarView(
        controller: _tabController,
        children: const [
          CommunityScreen(),
          ChatScreen(),
          StateScreen(),
          CallScreen(),
        ],
      ),
    );
  }
}

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
  itemFive,
}
