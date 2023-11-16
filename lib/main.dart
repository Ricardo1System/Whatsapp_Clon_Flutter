import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/contact/contact_bloc.dart';
import 'package:whatsapp_clone/firebase_options.dart';
import 'package:whatsapp_clone/repositories/contact_repository.dart';
import 'package:whatsapp_clone/repositories/user_repository.dart';
import 'package:whatsapp_clone/screens/contacts_screens/chat_ia_screen.dart'; 
import 'package:whatsapp_clone/screens/screen.dart';
import 'package:whatsapp_clone/settings.dart';
import 'package:whatsapp_clone/theme/dark_theme.dart';
import 'package:whatsapp_clone/theme/theme.dart';

import 'blocs/auth/auth_bloc.dart';
import 'screens/login_screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await PreferencesAppTheme.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  final UserRepository userRepository = UserRepository();
  final ContactRepository contactRepository = ContactRepository();

  runApp(MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              ThemeChange(1),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ChatAIProvider(),
        ),
        BlocProvider<AuthBloc>(
          lazy: false,
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ContactBloc>(
          lazy: false,
          create: (context) => ContactBloc(),
        )
      ],
      child: MyApp(
        userRepository: userRepository,
        contactRepository: contactRepository,
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.userRepository, required this.contactRepository});

  final UserRepository userRepository;
  final ContactRepository contactRepository;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   AuthBloc authBloc = AuthBloc();
  bool isAuthenticate=false;
  

  @override
  void initState() {
    super.initState();

    // Escuchar cambios en el estado de autenticación
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isAuthenticate = false;
      } else {
        isAuthenticate = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsApp>(
          lazy: false,
          create: (_) => SettingsApp(AppTheme.light),
        ),
        RepositoryProvider<UserRepository>(
          // lazy: false,
          create: (BuildContext context) => widget.userRepository,
        ),
        RepositoryProvider<ContactRepository>(
          // lazy: false,
          create: (BuildContext context) => widget.contactRepository ,
        ),
      ],
      child: Consumer<SettingsApp>(
        builder: (BuildContext context, SettingsApp provider, Widget? child) {
          return ScreenUtilInit(
            splitScreenMode: true,
            minTextAdapt: true,
            designSize: const Size(360, 690),
            builder: (context, child) {
              return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: Provider.of<ThemeChange>(context).currenttheme,
              home:  isAuthenticate? const HomeScreen():const LoginPage(),
            );
            },
          );
        },
      ),
    );
  }
} 

