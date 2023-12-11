import 'package:chat_app_frontend/constants/colors.dart';
import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:chat_app_frontend/models/user.dart';
import 'package:chat_app_frontend/providers/supabase_provider.dart';
import 'package:chat_app_frontend/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_picture.dart';

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
        title: const Text(
          'Iniciar sesión:',
          style: TextStyle(color: white, fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          var data = snapshot.data!;
          provider.users = data;
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) =>
                      _Item(provider: provider, user: data[index]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    required this.provider,
    required this.user,
  });

  final SupabaseProvider provider;
  final User user;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool onTap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => onTap = !onTap);
        widget.provider.myId = widget.user.id;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
      onTapDown: (_) => setState(() => onTap = !onTap),
      child: Container(
        decoration: BoxDecoration(
          color: white.withOpacity(onTap ? .1 : .03),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.user.name,
              style: const TextStyle(color: white, fontSize: 16),
            ),
            verticalSpace(15),
            ProfilePicture(
              url: widget.user.profilePictureUrl,
              radius: 40,
            ),
          ],
        ),
      ),
    );
  }
}
