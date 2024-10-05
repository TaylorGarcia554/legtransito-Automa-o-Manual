import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  final List<MenuOption> options;

  const MenuItems({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: options
          .map((option) => ListTile(
                title: Text(option.title),
                onTap: option.onTap,
              ))
          .toList(),
    );
  }
}

class MenuOption {
  final String title;
  final VoidCallback onTap;

  MenuOption({required this.title, required this.onTap});
}
