import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'alarm': Icons.alarm,
  'house': Icons.house,
  'dialog': Icons.pages,
  'smart_button': Icons.smart_button
};

Icon getUsableIcon(String iconName) {
  return Icon(_icons[iconName]);
}
