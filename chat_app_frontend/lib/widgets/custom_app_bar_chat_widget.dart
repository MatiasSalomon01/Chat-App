import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:chat_app_frontend/models/user.dart';
import 'package:chat_app_frontend/providers/chat_screen_provider.dart';
import 'package:chat_app_frontend/providers/supabase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/models.dart';
import 'widgets.dart';

class CustomAppBarChat extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarChat({super.key, required this.user});
  final User user;
  final double appBarHeight = kToolbarHeight;
  @override
  Widget build(BuildContext context) {
    final supabaseProvider =
        Provider.of<SupabaseProvider>(context, listen: false);
    return PreferredSize(
      preferredSize: Size.zero,
      child: SafeArea(
        child: Container(
          color: primary,
          height: appBarHeight,
          width: MediaQuery.of(context).size.width,
          child: Consumer<ChatScreenProvider>(
            builder: (_, chatScreenProvider, child) {
              if (chatScreenProvider.totalSelected > 0) {
                int count = chatScreenProvider.totalSelected;
                return Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CustomMaterialButton(
                            icon: Icons.arrow_back_outlined,
                            onTap: () =>
                                chatScreenProvider.resetStateOfSelectedTexts(),
                          ),
                          horizontalSpace(20),
                          Text(
                            '$count',
                            style: const TextStyle(color: white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    _Actions(
                      flex: count > 1 ? 1 : 2,
                      icons: count > 1
                          ? [
                              const CustomMaterialButton(
                                  icon: Icons.star_rounded),
                              const CustomMaterialButton(icon: Icons.delete),
                              const CustomMaterialButton(icon: Icons.copy),
                              Transform(
                                transform: Matrix4.identity()
                                  ..scale(-1.0, 1.0, 1.0),
                                alignment: Alignment.center,
                                child: const CustomMaterialButton(
                                    icon: Icons.reply),
                              ),
                            ]
                          : [
                              const CustomMaterialButton(
                                  icon: Icons.reply_sharp),
                              const CustomMaterialButton(
                                  icon: Icons.star_rounded),
                              const CustomMaterialButton(icon: Icons.delete),
                              Transform(
                                transform: Matrix4.identity()
                                  ..scale(-1.0, 1.0, 1.0),
                                alignment: Alignment.center,
                                child: const CustomMaterialButton(
                                    icon: Icons.reply),
                              ),
                              const CustomMaterialButton(icon: Icons.more_vert),
                            ],
                    ),
                    // horizontalSpace(50),
                    // Spacer(),
                    // if (count > 1) ...[
                    //   CustomMaterialButton(icon: Icons.star_rounded),
                    //   CustomMaterialButton(icon: Icons.delete),
                    //   CustomMaterialButton(icon: Icons.copy),
                    //   Transform(
                    //     transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    //     alignment: Alignment.center,
                    //     child: CustomMaterialButton(icon: Icons.reply),
                    //   ),
                    // ] else ...[
                    //   CustomMaterialButton(icon: Icons.reply_sharp),
                    //   CustomMaterialButton(icon: Icons.star_rounded),
                    //   CustomMaterialButton(icon: Icons.delete),
                    //   Transform(
                    //     transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    //     alignment: Alignment.center,
                    //     child: CustomMaterialButton(icon: Icons.reply),
                    //   ),
                    //   CustomMaterialButton(icon: Icons.more_vert),
                    // ]
                  ],
                );
                // return _Actions(
                //   icons: [
                // Text(
                //   '$count  ${count > 1 ? 'Mensajes' : 'Mensaje'}',
                //   style: const TextStyle(color: white),
                // ),
                //     GestureDetector(
                //       onTap: () async {
                //         await supabaseProvider
                //             .deleteMessages(chatScreenProvider.messagesIds);
                //         chatScreenProvider.resetStateOfSelectedTexts();
                //       },
                //       child: const Icon(Icons.delete, color: white, size: 20),
                //     ),
                //   ],
                // );
              }

              return child!;
            },
            child: _Content(user: user),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

class _Content extends StatelessWidget {
  const _Content({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Container(
                height: 40,
                width: 80,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Material(
                  color: transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => Navigator.pop(context),
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateProperty.all(hoverColor),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_outlined, color: white),
                        horizontalSpace(2),
                        ProfilePicture(
                          url: user.profilePictureUrl,
                          radius: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // horizontalSpace(10),
              Text(
                user.name,
                style: const TextStyle(color: white, fontSize: 17),
              ),
            ],
          ),
        ),
        const _Actions(
          icons: [
            Icon(Icons.videocam_rounded, color: white, size: 25),
            Icon(Icons.call, color: white, size: 20),
            Icon(Icons.more_vert, color: white, size: 22),
          ],
        ),
        // Consumer<ChatScreenProvider>(
        //   builder: (_, chatScreenProvider, child) {
        //     if (chatScreenProvider.totalSelected > 0) {
        //       int count = chatScreenProvider.totalSelected;
        //       return _Actions(
        //         icons: [
        //           Text(
        //             '$count  ${count > 1 ? 'Mensajes' : 'Mensaje'}',
        //             style: const TextStyle(color: white),
        //           ),
        //           GestureDetector(
        //             onTap: () async {
        //               await supabaseProvider
        //                   .deleteMessages(chatScreenProvider.messagesIds);
        //               chatScreenProvider.resetStateOfSelectedTexts();
        //             },
        //             child:
        //                 const Icon(Icons.delete, color: white, size: 20),
        //           ),
        //         ],
        //       );
        //     }

        //     return child!;
        //   },
        // child: const _Actions(
        //   icons: [
        //     Icon(Icons.videocam_rounded, color: white, size: 25),
        //     Icon(Icons.call, color: white, size: 20),
        //     Icon(Icons.more_vert, color: white, size: 22),
        //   ],
        // ),
        // ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({super.key, required this.icons, this.flex});

  final List<Widget> icons;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: icons,
      ),
    );
  }
}
