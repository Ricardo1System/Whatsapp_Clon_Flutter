import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/theme/classic_theme.dart';
import 'package:whatsapp_clone/theme/shared_preferences/preferences_app_theme.dart';

class CallScreen extends StatefulWidget {
   
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SwitchListTile(
              title: Text('Dark Mode', style: AppKiiubitTheme.textClassic18),
              value: PreferencesAppTheme.isDarkMode,
              onChanged: (value) {

                PreferencesAppTheme.isDarkMode = value; // Cambia el valor de isDarkMode en local storage
                final themeProvider = Provider.of<AppKiiubitTheme>(context, listen: false); // Instancia del provider
      
                value ? themeProvider.setDarkMode() : themeProvider.setLightMode(); // Llama a un método para establecer el tema

                AppKiiubitTheme.refreshTheme(); // Llama al App Theme para refrescar los colores del tema
      
                setState(() {});
              },
            ),
      ),
    );
  }
}