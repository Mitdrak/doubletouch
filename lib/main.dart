import 'package:flutter/material.dart';
import 'dart:math';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

void connectToSocketIO() {
  IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  socket.onConnect((_) {
    print('Connected to Socket.IO server');
    socket.emit('join', 'Flutter client');
  });

  socket.on('message', (data) {
    print('Received message: $data');
  });

  socket.onDisconnect((_) {
    print('Disconnected from Socket.IO server');
  });

  socket.connect();
}

double hola = 0;
bool dtouch = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _boxColor = Colors.blue;
  void iniState() {
    super.initState();
  }
  // IO.Socket? socket;
  //   connect();

  // void connect() {
  //   socket = IO.io("http://localhost:3000", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket!.connect();
  //   socket!.onConnect((_) {
  //     print('connected into frontend');
  //     //socket!.emit('msg', 'test');
  //   });
  // }

  void changeColor() {
    Random random = Random();

    setState(() {
      if (dtouch) {
        _boxColor = Colors.red;
      } else {
        _boxColor = Colors.blue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RawGestureDetector Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RawGestureDetector Example'),
        ),
        body: Center(
          child: Listener(
            onPointerDown: (opm) {
              hola = hola + 0.5;
              print(hola);
              if (hola >= 1) {
                dtouch = true;
                hola = 0;
                print(dtouch);
                changeColor();
                dtouch = false;
                connectToSocketIO();
              }
            },
            onPointerUp: (opc) {
              hola = hola - 0.5;
              changeColor();
              if (hola < 0) {
                hola = 0;
              }
            },
            child: Container(
              width: 300,
              height: 300,
              color: _boxColor,
              child: const Center(
                child: Text(
                  'hola',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
