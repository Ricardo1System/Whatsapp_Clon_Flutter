import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class ChatSettingsScreen extends StatefulWidget {
   
  const ChatSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ChatSettingsScreen> createState() => _ChatSettingsScreenState();
}

class _ChatSettingsScreenState extends State<ChatSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme=Provider.of<ThemeChange>(context).currenttheme;
    var isDark = Provider.of<ThemeChange>(context);
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back),),
        title: Text('Chats', style: appTheme.textTheme.bodyLarge),
      ),
      body: Center(
        child: SwitchListTile(
                title: Text('Dark Mode', style: appTheme.textTheme.bodyMedium!.copyWith(color: appTheme.colorScheme.primary) ),
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