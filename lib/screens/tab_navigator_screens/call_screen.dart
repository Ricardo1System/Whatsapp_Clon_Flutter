import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/theme/dark_theme.dart';
import 'package:whatsapp_clone/theme/theme.dart';
import 'package:whatsapp_clone/widgets/custom_page_fix.dart';

class CallScreen extends StatefulWidget {
   
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context, listen: true).currenttheme;
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      body: const Center(
        child: CustomPageFix(),
      ),
    );
  }
}