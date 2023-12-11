import 'package:chat_app_frontend/extensions/datime_extensions.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../helpers/sized_box_helper.dart';
import '../models/models.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, required this.isMe});

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isMe
          ? const EdgeInsets.only(left: 50)
          : const EdgeInsets.only(right: 50),
      child: Stack(
        children: [
          Column(
            children: [
              if (message.putSeparator) verticalSpace(8),
              Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isMe ? userGreen : primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.text,
                        style: const TextStyle(color: white),
                      ),
                      horizontalSpace(10),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          message.createdAt.getHour(),
                          style: TextStyle(
                            color: white.withOpacity(.6),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (message.putSeparator)
            SizedBox(
              width: MediaQuery.of(context).size.width * 9.5,
              child: Align(
                alignment: isMe ? Alignment.bottomRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomPaint(
                    painter: FirstMessagePin(isMe: isMe),
                  ),
                ),
              ),
            ),
        ],
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
