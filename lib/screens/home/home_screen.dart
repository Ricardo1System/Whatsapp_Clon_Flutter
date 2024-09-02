import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/user/user_bloc.dart';
import 'package:whatsapp_clone/models/user/user_dto.dart';
import 'package:whatsapp_clone/models/widgets/pop_menu_item_data.dart';
import 'package:whatsapp_clone/providers/current_user_provider.dart';
import 'package:whatsapp_clone/repositories/user_repository.dart';
import 'package:whatsapp_clone/screens/screen.dart';
import 'package:whatsapp_clone/screens/settings_screens/settings_screens.dart';
import 'package:whatsapp_clone/theme/theme.dart';
import 'package:whatsapp_clone/utils/common_dialog.dart';
import 'package:whatsapp_clone/widgets/custom_popup_menu_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  UserBloc? userBloc;
  UserDto? user;
  _SampleItem? selectedMenu;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    userBloc = UserBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context));
    userBloc!.add(GetProfile());
    super.initState();
  }

  void onSelected (_SampleItem item) {
              switch (item) {
                case _SampleItem.itemFive:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                  break;
                default:
              }
            }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    final userProvider = Provider.of<CurrentUserProvider>(context, listen: true);
    final itemDataList = <PopupMenuItemData<_SampleItem>>[
     PopupMenuItemData<_SampleItem>(value: _SampleItem.itemOne, child: 'Nuevo grupo'),
     PopupMenuItemData<_SampleItem>(value: _SampleItem.itemTwo, child: 'Nueva difusión'),
     PopupMenuItemData<_SampleItem>(value: _SampleItem.itemThree, child: 'Dispositivos vinculados'),
     PopupMenuItemData<_SampleItem>(value: _SampleItem.itemFour, child: 'Mensajes destacados'),
     PopupMenuItemData<_SampleItem>(value: _SampleItem.itemFive, child: 'Ajustes'),
    ]; 

    
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Whatsapp Clone'),
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: appTheme.colorScheme.onBackground,
          dividerColor: appTheme.colorScheme.onBackground,
          indicatorColor: appTheme.colorScheme.onBackground,
          splashBorderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          tabs: const <Widget>[
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
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          CustomPopuoMenuButton(
            initialValue: selectedMenu,
            onSelected: (value) => onSelected(value!),
            itemBuilder: () => List.generate(itemDataList.length, (index) => PopupMenuItem<_SampleItem>(
                value: itemDataList[index].value,
                child: Text(
                  itemDataList[index].child,
                  style: appTheme.textTheme.bodyMedium!
                      .copyWith(color: appTheme.colorScheme.surface),
                ),
              )),
          )
        ],
      ),
      // bottomNavigationBar: ,
      body: BlocListener<UserBloc, UserState>(
        bloc: userBloc,
                  listener: (context, state) {
            if (state is GetInformationLoading) {
              showProgress(context);
            }
            if (state is GetInformationLoaded) {
              hideProgress(context);
              userProvider.loadUserProperties = state.user;
              setState(() {
                user = state.user;
              });
            }
          },
        child: _Body(tabController: _tabController),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required TabController? tabController,
  }) : _tabController = tabController;

  final TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: const [
        CommunityScreen(),
        ChatScreen(),
        StateScreen(),
        CallScreen(),
      ],
    );
  }
}

enum _SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
  itemFive,
}


