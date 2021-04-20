import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:fluttergame/entities/player.dart';
import 'package:fluttergame/game_core/main_loop.dart';
import 'package:fluttergame/game_core/utilities.dart/global_vars.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  ReceivePort _receivePort;
  Isolate _isolateLoop;

  void _startIsolateLoop() async {
    _receivePort = ReceivePort();
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);
    _receivePort.listen((message) {
      GlobalVars.currentScene.update();
      setState(() {});
    });
  }

  @override
  void initState() {
    _startIsolateLoop();
    super.initState();
  }

  @override
  void dispose() {
    _receivePort.close();
    _isolateLoop.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GlobalVars.currentScene.buildScene();
}
