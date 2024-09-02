import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/chat/chat_bloc.dart';
import 'package:whatsapp_clone/blocs/contact/contact_bloc.dart';
import 'package:whatsapp_clone/firebase_options.dart';
import 'package:whatsapp_clone/providers/chat_ai_provider.dart';
import 'package:whatsapp_clone/providers/current_user_provider.dart';
import 'package:whatsapp_clone/repositories/contact_repository.dart';
import 'package:whatsapp_clone/repositories/user_repository.dart';
import 'package:whatsapp_clone/screens/screen.dart';
import 'package:whatsapp_clone/services/firebase/auth_service.dart';
import 'package:whatsapp_clone/settings.dart';
import 'package:whatsapp_clone/theme/theme.dart';

import 'blocs/auth/auth_bloc.dart';
import 'screens/login_screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await PreferencesAppTheme.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'), Web
    androidProvider: AndroidProvider.debug, //Android
    // appleProvider: AppleProvider.appAttest, IOS
  );

  final UserRepository userRepository = UserRepository();
  final ContactRepository contactRepository = ContactRepository();

  runApp(MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeChange(1),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatAIProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => CurrentUserProvider(),
        ),
        BlocProvider<AuthBloc>(
          lazy: false,
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ContactBloc>(
          lazy: false,
          create: (context) => ContactBloc(),
        ),
        BlocProvider<ChatBloc>(
          lazy: false,
          create: (context) => ChatBloc(),
        ),
      ],
      child: MyApp(
        userRepository: userRepository,
        contactRepository: contactRepository,
      )));
}

class MyApp extends StatefulWidget {
  const MyApp(
      {super.key,
      required this.userRepository,
      required this.contactRepository});

  final UserRepository userRepository;
  final ContactRepository contactRepository;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();
  AuthBloc authBloc = AuthBloc();
  bool isAuthenticate = false;

  @override
  void initState() {
    super.initState();
    authService.isAuthenticated.listen((response) {
      setState(() {
        isAuthenticate = response;
      });
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
          lazy: false,
          create: (BuildContext context) => widget.userRepository,
        ),
        RepositoryProvider<ContactRepository>(
          // lazy: false,
          create: (BuildContext context) => widget.contactRepository,
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
                home: isAuthenticate ? const HomeScreen() : const LoginPage(),
              );
            },
          );
        },
      ),
    );
  }
}
