import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = ["Chats", "Novedades", "Llamadas"];
    return Scaffold(
      backgroundColor: secondary,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const NavBar(),
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    titles[index],
                    style: const TextStyle(color: white),
                  ),
                );
              },
              itemCount: titles.length,
            ),
          ),
        ],
      ),
    );
  }
}
