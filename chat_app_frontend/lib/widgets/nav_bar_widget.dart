import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'widgets.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            title: 'Chats',
            isSelected: true,
          ),
          NavBarItem(
            title: 'Novedades',
            isSelected: false,
          ),
          NavBarItem(
            title: 'Llamadas',
            isSelected: false,
          ),
        ],
      ),
    );
  }
}
