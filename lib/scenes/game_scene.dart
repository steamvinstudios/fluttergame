import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttergame/entities/player.dart';
import 'package:fluttergame/game_core/utilities.dart/global_vars.dart';
import 'package:fluttergame/scenes/app_scene.dart';

class GameScene extends AppScene {
  Player _player = Player();
  double _startGlobalPosition = 0;

  @override
  Widget buildScene() {
    return Stack(
      children: [
        _player.build(),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              width: GlobalVars.screenWidth / 2,
              height: GlobalVars.screenHeight,
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
              ),
            ))
      ],
    );
  }

  @override
  void update() {
    _player.update();
  }

  GameScene();

  void _onPanStart(DragStartDetails details) {
    _startGlobalPosition = details.globalPosition.dx;
    print(_startGlobalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double updateGlobalPosition = details.globalPosition.dx;
    if (updateGlobalPosition > _startGlobalPosition + 30) {
      _player.isMoveRight = true;
    }
    if (updateGlobalPosition < _startGlobalPosition - 30) {
      _player.isMoveLeft = true;
    }
  }
}
