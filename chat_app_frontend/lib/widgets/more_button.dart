import 'package:chat_app_frontend/pages/pages.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashFactory: NoSplash.splashFactory),
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        color: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.black,
        offset: const Offset(10, kToolbarHeight - 10),
        tooltip: '',
        onSelected: (value) {
          if (value == 6) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectUserPage(),
              ),
            );
          }
        },
        itemBuilder: (context) {
          return const [
            PopupMenuItem(
              child: Text(
                'Nuevo grupo',
                style: TextStyle(color: white, fontSize: 18),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Nueva difusión',
                style: TextStyle(color: white, fontSize: 18),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Dispositivos vinculados',
                style: TextStyle(color: white, fontSize: 18),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Mensajes destacados',
                style: TextStyle(color: white, fontSize: 18),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Ajustes',
                style: TextStyle(color: white, fontSize: 18),
              ),
            ),
            PopupMenuItem(
              value: 6,
              child: Text(
                'Cerrar sesión',
                style: TextStyle(color: white, fontSize: 18),
              ),
            ),
          ];
        },
        child: const Icon(
          Icons.more_vert,
          color: white,
          size: 25,
        ),
      ),
    );
  }
}
