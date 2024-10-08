import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _boxSize = 150.0;
  int _numTaps = 0;
  int _numDoubleTaps = 0;
  int _numLongPress = 0;
  double posX = 0.0;
  double posY = 0.0;

  void center(BuildContext context) {
    posX = (MediaQuery.of(context).size.width / 2) - _boxSize / 2;
    posY = (MediaQuery.of(context).size.height / 2) - _boxSize / 2 - 30;

    setState(() {
      posX = posX;
      posY = posY;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (posX == 0) {
      center(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Detecture'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: posY,
            left: posX,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _numTaps++;
                });
              },
              onDoubleTap: () {
                setState(() {
                  _numDoubleTaps++;
                });
              },
              onLongPress: () {
                setState(() {
                  _numLongPress++;
                });
              },
              // onVerticalDragUpdate: (DragUpdateDetails details) {
              //   setState(() {
              //     double delta = details.delta.dy;
              //     posY += delta;
              //   });
              // },
              // onHorizontalDragUpdate: (DragUpdateDetails details) {
              //   setState(() {
              //     double delta = details.delta.dx;
              //     posX += delta;
              //   });
              // },
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  double deltaX = details.delta.dx;
                  double deltaY = details.delta.dy;

                  posX += deltaX;
                  posY += deltaY;
                });
              },
              child: Container( 
                width: _boxSize,
                height: _boxSize,
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Taps: $_numTaps - Double Taps: $_numDoubleTaps - Long Press: $_numLongPress',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
