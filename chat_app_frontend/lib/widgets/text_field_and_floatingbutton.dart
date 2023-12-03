import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/supabase.dart';
import '../helpers/sized_box_helper.dart';
import '../providers/supabase_provider.dart';

class TextFieldAndFloatingButton extends StatefulWidget {
  const TextFieldAndFloatingButton({
    super.key,
    required this.receiverId,
  });

  final int receiverId;

  @override
  State<TextFieldAndFloatingButton> createState() =>
      _TextFieldAndFloatingButtonState();
}

class _TextFieldAndFloatingButtonState
    extends State<TextFieldAndFloatingButton> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              cursorColor: green,
              style: const TextStyle(color: grey, fontSize: 18, height: 1.3),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Icon(Icons.emoji_emotions_rounded),
                prefixIconColor: grey,
                suffixIconColor: grey,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.share),
                      horizontalSpace(10),
                      const Icon(Icons.camera_alt),
                    ],
                  ),
                ),
                hintStyle:
                    const TextStyle(color: grey, fontSize: 18, height: 1.3),
                hintText: 'Mensaje',
                fillColor: primary,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
              onFieldSubmitted: (value) {
                final provider =
                    Provider.of<SupabaseProvider>(context, listen: false);
                provider.sendMessage(value, provider.myId, widget.receiverId);

                _controller.clear();
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: greenAccent3,
            elevation: 0,
            child: const Icon(Icons.keyboard_voice_rounded),
          ),
        ],
      ),
    );
  }
}
