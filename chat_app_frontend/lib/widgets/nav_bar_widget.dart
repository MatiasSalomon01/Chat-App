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
        children: const [
          NavBarItem(
            pageIndex: 0,
            title: 'Chats',
          ),
          NavBarItem(
            pageIndex: 1,
            title: 'Novedades',
          ),
          NavBarItem(
            pageIndex: 2,
            title: 'Llamadas',
          ),
        ],
      ),
    );
  }
}
