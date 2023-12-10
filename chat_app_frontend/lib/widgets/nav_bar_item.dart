import 'package:chat_app_frontend/providers/nav_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class NavBarItem extends StatefulWidget {
  const NavBarItem({
    super.key,
    required this.pageIndex,
    required this.title,
  });

  final int pageIndex;
  final String title;

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarProvider>(builder: (context, provider, child) {
      bool isSelected = provider.currentIndex == widget.pageIndex;
      return Expanded(
        child: GestureDetector(
          onTapDown: (_) => setState(() => isPressed = true),
          onTapUp: (_) {
            setState(() => isPressed = false);
            provider.goTo(widget.pageIndex);
          },
          child: Container(
            height: 50,
            color: isPressed ? hoverColor : transparent,
            padding: const EdgeInsets.only(top: 13.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: isSelected ? green : grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                // verticalSpace(12),
                if (isSelected)
                  Container(
                    height: 3,
                    color: green,
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
