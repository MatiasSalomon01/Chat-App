import 'package:chat_app_frontend/constants/colors.dart';
import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:chat_app_frontend/models/user.dart';
import 'package:chat_app_frontend/providers/supabase_provider.dart';
import 'package:chat_app_frontend/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_picture.dart';

class SelectUserPage extends StatefulWidget {
  const SelectUserPage({super.key});

  @override
  State<SelectUserPage> createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage> {
  final TextEditingController _controller = TextEditingController(text: '');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> createUser(SupabaseProvider provider) async {
    await provider.createUser(_controller.text);
    _controller.clear();
    Navigator.pop(context);
  }

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
        actions: [
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(primary),
              splashFactory: NoSplash.splashFactory,
              shape: MaterialStatePropertyAll(CircleBorder()),
              elevation: MaterialStatePropertyAll(0),
            ),
            onPressed: () => showModal(context, provider),
            child: const Icon(Icons.add),
          ),
          // horizontalSpace(10),
        ],
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
                Expanded(
                  child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => _Item(
                      provider: provider,
                      user: data[index],
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

  Future<dynamic> showModal(BuildContext context, SupabaseProvider provider) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primary,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ingrese su nombre:',
                style: TextStyle(color: white),
              ),
              verticalSpace(10),
              TextFormField(
                controller: _controller,
                cursorColor: green,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(color: grey, fontSize: 18, height: 1.3),
                onFieldSubmitted: (_) => createUser(provider),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: white.withOpacity(.1),
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => createUser(provider),
              child: Text('Crear', style: TextStyle(color: white)),
              style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(white.withOpacity(.2)),
                backgroundColor:
                    MaterialStatePropertyAll(white.withOpacity(.1)),
              ),
            )
          ],
        );
      },
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
        widget.provider.myId = widget.user.id!;
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
        child: Stack(
          children: [
            Center(
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
            Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                onTap: () => widget.provider.deleteUser(widget.user.id!),
                child: Icon(
                  Icons.close,
                  color: grey,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
