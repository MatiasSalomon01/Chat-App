import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../helpers/sized_box_helper.dart';
import '../models/models.dart';
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

class _TextFieldAndFloatingButtonState extends State<TextFieldAndFloatingButton>
    with TickerProviderStateMixin {
  late final TextEditingController _controller;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = Tween(begin: .7, end: 1.0).animate(_scaleController);
    _controller = TextEditingController(text: '');

    _controller.addListener(listener);
  }

  @override
  void dispose() {
    _scaleController.dispose();
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
              keyboardType: TextInputType.multiline,
              style: const TextStyle(color: grey, fontSize: 18, height: 1.3),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Icon(Icons.emoji_emotions_rounded),
                prefixIconColor: grey,
                suffixIconColor: grey,
                suffixIcon: Container(
                  constraints: const BoxConstraints(maxWidth: 80),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 150),
                        right: hasText ? -40 : 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.share),
                              horizontalSpace(15),
                              const Icon(Icons.camera_alt),
                            ],
                          ),
                        ),
                      ),
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
            ),
          ),
          FloatingActionButton(
            onPressed: () async => hasText ? await sendMessage() : {},
            backgroundColor: greenAccent3,
            elevation: 0,
            child: AnimatedBuilder(
              animation: _scaleController,
              builder: (context, child) {
                return Transform.scale(
                  scale:
                      _scaleController.isDismissed ? 1 : _scaleAnimation.value,
                  child: Icon(
                    hasText ? Icons.send : Icons.keyboard_voice_rounded,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> listener() async {
    if (_controller.text.isEmpty && !hasText ||
        _controller.text.isNotEmpty && hasText) {
      return;
    }

    if (_controller.text.isNotEmpty && !hasText ||
        _controller.text.isEmpty && hasText) {
      setState(() => hasText = !hasText);

      await _scaleController.forward();
      _scaleController.reset();
    }
  }

  Future<void> sendMessage() async {
    final provider = Provider.of<SupabaseProvider>(context, listen: false);
    await provider.sendMessage(
      _controller.text,
      provider.myId,
      widget.receiverId,
    );

    final lastMessage = ChatLastMessage(
      senderId: provider.myId,
      receiverId: widget.receiverId,
      text: _controller.text,
      date: DateTime.now(),
    );

    await provider.insertLastMessage(lastMessage);

    _controller.clear();
  }
}
