import 'package:chat_app_frontend/constants/supabase.dart';
import 'package:chat_app_frontend/pages/pages.dart';
import 'package:chat_app_frontend/providers/nav_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/supabase_provider.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url, anonKey: anonKey);
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SupabaseProvider(),
        )
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      home: SelectUserPage(),
    );
  }
}

// class Home extends StatefulWidget {
//   const Home({
//     super.key,
//   });
//   // final String serverUrl = 'http://localhost:5003/chat-hub';
//   final String serverUrl = 'http://10.0.2.2:5003/chat-hub';

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   _HomeState();

//   late final HubConnection connection;
//   List<String> messages = [];
//   UniqueKey key = UniqueKey();
//   bool isChatRoom = false;
//   bool isTyping = false;
//   String userName = '';
//   // final Map<String, List<String>> content = {};
//   List<Content> content = [];
//   final TextEditingController chatController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   @override
//   void dispose() {
//     chatController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     buildConnection();
//     connection.onclose((exception) => onClosed);
//     connection.on(
//       'ReceiveMessage',
//       (arguments) async {
//         for (var argument in arguments!) {
//           content.add(
//             Content(user: argument["user"], message: argument["message"]),
//           );
//         }
//         setState(() {});
//       },
//     );
//     connection.on("ReceiveIsTyping", (arguments) {
//       setState(() {
//         isTyping = arguments!.first as bool;
//       });
//     });
//   }

//   buildConnection() {
//     connection = HubConnectionBuilder().withUrl(widget.serverUrl).build();
//   }

//   void onClosed(Exception exception) => print('connection closed');

//   Future connect() async {
//     await connection.start();
//   }

//   Future sendAll(String message) async {
//     await connection.invoke('SendAll', args: [userName, message]);
//   }

//   Future sendIsTyping(bool isTyping) async {
//     await connection.invoke('SendIsTyping', args: [isTyping]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 29, 75, 62),
//         title: const Text(
//           'CHAT - APP',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           if (isTyping) ...[
//             Text("...escribiendo",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(width: 100),
//           ],
//           Text(userName, style: const TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(width: 100),
//         ],
//       ),
//       backgroundColor: const Color.fromARGB(255, 37, 36, 36),
//       body: isChatRoom
//           ? Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     reverse: true,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 50),
//                       child: Column(
//                         children: [
//                           ...content.map(
//                             (e) => Align(
//                               alignment: e.user != userName
//                                   ? Alignment.bottomLeft
//                                   : Alignment.bottomRight,
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 margin:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   color: e.user != userName
//                                       ? const Color.fromARGB(255, 43, 44, 44)
//                                       : const Color.fromARGB(255, 29, 75, 62),
//                                 ),
//                                 child: Text(
//                                   e.message.toString(),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(50),
//                   child: TextFormField(
//                     controller: chatController,
//                     focusNode: _focusNode,
//                     style: const TextStyle(color: Colors.white),
//                     cursorColor: Colors.grey,
//                     onChanged: (value) {
//                       sendIsTyping(true);
//                     },
//                     onFieldSubmitted: (value) {
//                       sendAll(value);
//                       chatController.text = '';
//                     },
//                     decoration: const InputDecoration(
//                       filled: true,
//                       fillColor: Color.fromARGB(255, 29, 75, 62),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white, width: .5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black, width: .5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white, width: .5),
//                       ),
//                       disabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black, width: .5),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                       width: 250,
//                       child: TextFormField(
//                         style: const TextStyle(color: Colors.white),
//                         cursorColor: Colors.grey,
//                         onFieldSubmitted: (value) async {
//                           setState(() => userName = value);
//                           await enterChat();
//                         },
//                         decoration: const InputDecoration(
//                           filled: true,
//                           fillColor: Color.fromARGB(255, 29, 75, 62),
//                           border: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.white, width: .5),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.black, width: .5),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.white, width: .5),
//                           ),
//                           disabledBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.black, width: .5),
//                           ),
//                         ),
//                       )),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                         const Color.fromARGB(255, 29, 75, 62),
//                       ),
//                       padding:
//                           MaterialStateProperty.all(const EdgeInsets.all(25)),
//                       shape: MaterialStateProperty.all(
//                         const StadiumBorder(
//                           side: BorderSide(color: Colors.white, width: .3),
//                         ),
//                       ),
//                     ),
//                     onPressed: () async => enterChat(),
//                     child: const Text(
//                       'Send Message',
//                       style: TextStyle(fontSize: 17),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//       // body: Center(
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.center,
//       //     children: [
//       //       const Text('CHAT APP'),
//       //       ...messages.map((e) => Text(e)).toList(),
//       // ElevatedButton(
//       //   onPressed: () async {
//       //     sendMessage(UniqueKey().toString());
//       //   },
//       //   child: const Text('Send Message'),
//       // )
//       //     ],
//       //   ),
//       // ),
//       // floatingActionButton: FloatingActionButton(
//       //   child: const Icon(Icons.cloud_done_outlined),
//       //   onPressed: () async => await connect(),
//       // ),
//     );
//   }

//   Future enterChat() async {
//     setState(() => isChatRoom = true);
//     await connect();
//   }
// }
