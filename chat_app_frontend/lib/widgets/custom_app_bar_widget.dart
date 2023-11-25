import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.zero,
      child: Container(
        color: primary,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'WhatsApp',
                      style: TextStyle(
                          color: white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.photo_camera_outlined,
                      color: white,
                      size: 25,
                    ),
                    horizontalSpace(20),
                    const Icon(
                      Icons.search,
                      color: white,
                      size: 25,
                    ),
                    horizontalSpace(15),
                    const Icon(
                      Icons.more_vert,
                      color: white,
                      size: 25,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30);
}
