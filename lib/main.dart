import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

double hola = 0;
bool dtouch = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _boxColor = Colors.blue;

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
