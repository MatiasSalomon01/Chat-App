import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });
  final String serverUrl = 'http://localhost:5003/chat-hub';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState();

  late final HubConnection connection;
  List<String> messages = [];
  UniqueKey key = UniqueKey();

  @override
  void initState() {
    super.initState();
    buildConnection();
    connection.onclose((exception) => onClosed);
    connection.on('ReceiveMessage', receiveMessage);
  }

  buildConnection() {
    connection = HubConnectionBuilder()
        .withUrl(widget.serverUrl,
            HttpConnectionOptions(logging: (level, message) => print(message)))
        .build();
  }

  void onClosed(Exception exception) => print('connection closed');

  Future connect() async {
    await connection.start();
  }

  Future sendMessage(String message) async {
    await connection.invoke('SendMessage', args: ['Matias $key', message]);
  }

  Future receiveMessage(dynamic message) async {
    var value = message[1].toString();
    messages.add(value);
    print(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('CHAT APP'),
            ...messages.map((e) => Text(e)).toList(),
            ElevatedButton(
              onPressed: () async {
                sendMessage(UniqueKey().toString());
              },
              child: const Text('Send Message'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_done_outlined),
        onPressed: () async => await connect(),
      ),
    );
  }
}
