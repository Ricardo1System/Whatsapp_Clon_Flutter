import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/screens/screen.dart';
import 'package:whatsapp_clone/settings.dart';
import 'package:whatsapp_clone/theme/classic_theme.dart';

import 'theme/shared_preferences/preferences_app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesAppTheme.init();
  // runApp( const AppState());
  runApp(MultiBlocProvider(providers: [
    ChangeNotifierProvider(
      create: (_) =>
          AppKiiubitTheme(enabledDarkMode: PreferencesAppTheme.isDarkMode),
    ),
  ], child: const AppState()));
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Settings>(
          create: (_) => Settings(AppTheme.light),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (BuildContext context, Settings provider, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Provider.of<AppKiiubitTheme>(context).currentTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
