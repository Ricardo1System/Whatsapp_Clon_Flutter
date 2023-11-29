import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/theme/theme.dart';
import 'package:whatsapp_clone/widgets/custom_page_fix.dart';

class StateScreen extends StatelessWidget {
   
  const StateScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final appTheme=Provider.of<ThemeChange>(context, listen: true).currenttheme;
    return Scaffold(
      backgroundColor: appTheme.colorScheme.background,
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },
      child: const Icon(Icons.camera_alt_rounded),
      ),
      body: Center(child: CustomPageFix()),
    );
  }
}