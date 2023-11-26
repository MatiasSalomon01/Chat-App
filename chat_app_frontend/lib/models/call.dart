import 'package:flutter/material.dart';

class Call {
  final String name;
  final DateTime date;
  final bool wasAnswered;
  final IconData icon;
  final String? profilePictureUrl;

  Call({
    required this.name,
    required this.date,
    required this.wasAnswered,
    required this.icon,
    required this.profilePictureUrl,
  });

  static List<Call> mockData = [
    Call(
      name: 'Titulo 1',
      date: DateTime.now(),
      wasAnswered: false,
      icon: Icons.call,
      profilePictureUrl: "https://picsum.photos/200",
    ),
    Call(
      name: 'Titulo 2',
      date: DateTime.now(),
      wasAnswered: false,
      icon: Icons.call,
      profilePictureUrl: "https://picsum.photos/200",
    ),
    Call(
      name: 'Titulo 3',
      date: DateTime.now(),
      wasAnswered: true,
      icon: Icons.videocam_rounded,
      profilePictureUrl: "https://picsum.photos/200",
    ),
    Call(
      name: 'Titulo 4',
      date: DateTime.now(),
      wasAnswered: false,
      icon: Icons.videocam_rounded,
      profilePictureUrl: "https://picsum.photos/200",
    ),
    Call(
      name: 'Titulo 5',
      date: DateTime.now(),
      wasAnswered: true,
      icon: Icons.call,
      profilePictureUrl: "https://picsum.photos/200",
    ),
    Call(
      name: 'Titulo 6',
      date: DateTime.now(),
      wasAnswered: false,
      icon: Icons.videocam_rounded,
      profilePictureUrl: "https://picsum.photos/200",
    ),
  ];
}
