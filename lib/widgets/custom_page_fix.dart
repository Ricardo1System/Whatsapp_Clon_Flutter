import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class CustomPageFix extends StatelessWidget {
  const CustomPageFix({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Icon(Icons.now_widgets_rounded, color: appTheme.colorScheme.primary,size: 40,),
        const SizedBox(height: 100, ),
        Text('Pantalla en mantenimiento',
        style: appTheme.textTheme.bodyLarge!.copyWith(color: appTheme.colorScheme.surface) ,),
      ],
    );
  }
}