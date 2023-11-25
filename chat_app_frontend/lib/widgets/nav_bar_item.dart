import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../helpers/sized_box_helper.dart';

class NavBarItem extends StatefulWidget {
  const NavBarItem({
    super.key,
    required this.title,
    required this.isSelected,
  });

  final String title;
  final bool isSelected;

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        child: Container(
          height: 50,
          color: isPressed ? white.withOpacity(.1) : transparent,
          padding: const EdgeInsets.only(top: 13.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.isSelected ? green : grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              verticalSpace(12),
              if (widget.isSelected)
                Container(
                  height: 3,
                  color: green,
                )
            ],
          ),
        ),
      ),
    );
  }
}
