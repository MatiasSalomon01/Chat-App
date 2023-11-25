import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../providers/nav_bar_provider.dart';

class CustomFloatinActionButton extends StatelessWidget {
  const CustomFloatinActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context);

    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: greenAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      splashColor: transparent,
      child: Icon(getPageIcon(navBarProvider.currentIndex), color: secondary),
    );
  }

  IconData getPageIcon(int index) {
    switch (index) {
      case 0:
        return Icons.chat;
      case 1:
        return Icons.camera_alt;
      case 2:
        return Icons.add_ic_call_rounded;
      default:
        return Icons.chat;
    }
  }
}
