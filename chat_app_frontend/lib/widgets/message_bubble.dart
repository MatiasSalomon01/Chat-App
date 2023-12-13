import 'dart:io';

import 'package:chat_app_frontend/extensions/datime_extensions.dart';
import 'package:chat_app_frontend/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../helpers/sized_box_helper.dart';
import '../models/models.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({super.key, required this.message, required this.isMe});

  final Message message;
  final bool isMe;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool isTextSelected = false;
  @override
  Widget build(BuildContext context) {
    final chatScreenProvider =
        Provider.of<ChatScreenProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (widget.isMe) {
          setState(() => isTextSelected = !isTextSelected);

          chatScreenProvider.registerSelectedText(
            isTextSelected,
            widget.message.id,
          );
        }
      },
      child: Container(
        color: isTextSelected ? white.withOpacity(.2) : transparent,
        child: Stack(
          children: [
            Column(
              children: [
                if (widget.message.putSeparator) verticalSpace(8),
                Align(
                  alignment: widget.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: widget.isMe ? userGreen : primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: Platform.isAndroid
                                ? MediaQuery.of(context).size.width * .75
                                : MediaQuery.of(context).size.width * .8,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              widget.message.text,
                              maxLines: 10,
                              style:
                                  const TextStyle(color: white, fontSize: 14.5),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            widget.message.createdAt.getHour(),
                            style: TextStyle(
                              color: white.withOpacity(.6),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        horizontalSpace(10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (widget.message.putSeparator)
              Container(
                alignment:
                    widget.isMe ? Alignment.bottomRight : Alignment.centerLeft,
                padding: widget.isMe ? const EdgeInsets.only(right: 12) : null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:
                      CustomPaint(painter: FirstMessagePin(isMe: widget.isMe)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FirstMessagePin extends CustomPainter {
  FirstMessagePin({required this.isMe});

  final bool isMe;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isMe ? userGreen : primary
      ..style = PaintingStyle.fill;

    Path path = Path();

    if (isMe) {
      path.moveTo(-5, 0);
      path.lineTo(8, 0);
      path.quadraticBezierTo(11, 1, 8, 3);
      path.lineTo(3, 8);
      path.close();
    } else {
      path.moveTo(17, 0);
      path.lineTo(4, 0);
      path.quadraticBezierTo(1, 1, 4, 3);
      path.lineTo(9, 8);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
