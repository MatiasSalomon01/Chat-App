// import 'package:chat_app_frontend/constants/colors.dart';
// import 'package:flutter/material.dart';

// import '../constants/supabase.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: secondary,
//       body: FutureBuilder(
//         future: supabase.from('Users').select('name'),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }

//           if (snapshot.hasError) return const Text('ERROR');

//           final data = snapshot.data as List<dynamic>;
//           return ListView.builder(
//             itemBuilder: (context, index) {
//               return Text(
//                 data[index]['name']!,
//                 style: TextStyle(color: white, fontSize: 20),
//               );
//             },
//             itemCount: data.length,
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => getData(),
//       ),
//     );
//   }
// }
