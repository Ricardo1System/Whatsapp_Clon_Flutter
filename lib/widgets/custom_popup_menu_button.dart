

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class CustomPopuoMenuButton<T> extends StatelessWidget {
  const CustomPopuoMenuButton(
      {super.key,
      required this.onSelected,
      required this.initialValue,
      // required this.menuItems,
      required this.itemBuilder});

  final Function(T) onSelected;
  final T initialValue;
  // final List<T> menuItems;
  final List<PopupMenuEntry<T>> Function() itemBuilder;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    return PopupMenuButton<T>(
            initialValue: initialValue,
            surfaceTintColor: appTheme.colorScheme.primary,
            shadowColor: appTheme.colorScheme.surface,
            position: PopupMenuPosition.under,
            onSelected: (value) => onSelected(value),
            itemBuilder: (context) => itemBuilder(),
          );
  }
}