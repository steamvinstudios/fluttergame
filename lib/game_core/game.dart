import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:fluttergame/entities/player.dart';
import 'package:fluttergame/game_core/main_loop.dart';
import 'package:fluttergame/game_core/utilities.dart/common_vars.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  ReceivePort _receivePort;
  Isolate _isolateLoop;
  Player player;

  void startIsolateLoop() async {
    _receivePort = ReceivePort();
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);
    _receivePort.listen((message) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstStartGame) {
      startIsolateLoop();
      isFirstStartGame = false;
      player = Player();
    }

    player.update();

    return Stack(
      children: [player.build()],
    );
  }
}
