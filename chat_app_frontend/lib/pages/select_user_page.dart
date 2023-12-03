import 'package:chat_app_frontend/constants/colors.dart';
import 'package:chat_app_frontend/providers/supabase_provider.dart';
import 'package:chat_app_frontend/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectUserPage extends StatelessWidget {
  const SelectUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SupabaseProvider>(context);
    final users = provider.usersToSelect();
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(
          'Iniciar sesión como:',
          style: const TextStyle(color: white, fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          var data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usuario disponibles',
                  style: const TextStyle(color: white, fontSize: 17),
                ),
                ...data.map(
                  (e) => TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primary),
                      overlayColor: MaterialStateProperty.all(secondary),
                    ),
                    onPressed: () {
                      provider.myId = e.id;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      e.name,
                      style: TextStyle(color: white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
