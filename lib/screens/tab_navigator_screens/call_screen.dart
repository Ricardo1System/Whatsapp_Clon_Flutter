import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/theme/dark_theme.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class CallScreen extends StatefulWidget {
   
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context, listen: false).currenttheme;
    var isDark = Provider.of<ThemeChange>(context);
    return Scaffold(
      body: Center(
        child: SwitchListTile(
              title: Text('Dark Mode', style: appTheme.textTheme.bodyMedium ),
              value: isDark.darkTheme,
              onChanged: (value) {
                isDark.darkTheme=value; 
                setState(() {});
              },
            ),
      ),
    );
  }
}