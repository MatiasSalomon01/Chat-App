import 'package:chat_app_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/months.dart';
import '../helpers/sized_box_helper.dart';
import '../models/models.dart';

class CustomListTileCall extends StatelessWidget {
  const CustomListTileCall({
    super.key,
    required this.call,
  });
  final Call call;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePicture(url: call.profilePictureUrl),
        horizontalSpace(12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                call.name,
                style: TextStyle(
                  color: call.wasAnswered ? white : red,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpace(5),
              Row(
                children: [
                  Transform.rotate(
                    angle: -3,
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      color: call.wasAnswered ? green : red,
                      size: 18,
                    ),
                  ),
                  horizontalSpace(5),
                  Text(
                    formatedDate(call.date),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: grey, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        Icon(
          call.icon,
          color: green,
        )
      ],
    );
  }

  String formatedDate(DateTime date) =>
      '${date.day} de ${months[date.month]}, ${date.hour}:${date.minute}';
}
