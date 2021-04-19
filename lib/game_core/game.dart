import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:fluttergame/game_core/main_loop.dart';
import 'package:fluttergame/game_core/utilities.dart/common_vars.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  double x = 150;
  double y = 200;
  ReceivePort _receivePort;
  Isolate _isolateLoop;

  void startIsolateLoop() async {
    _receivePort = ReceivePort();
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);
    _receivePort.listen((message) {
      setState(() {});
      x++;
      if (x > 500) {
        x = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstStartGame) {
      startIsolateLoop();
      isFirstStartGame = false;
    }
    return Stack(
      children: [Positioned(top: y, left: x, child: Text("awesome game"))],
    );
  }
}
