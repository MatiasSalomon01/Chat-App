import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomAppBar(),
    );
  }
}
