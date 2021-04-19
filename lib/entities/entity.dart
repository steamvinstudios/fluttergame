import 'package:flutter/material.dart';

abstract class Entity {
  double x;
  double y;
  String spritename;
  bool visinle = true;
  List sprites = [];

  Entity(this.spritename) {
    for (var i = 0; i < 4; i++) {
      sprites.add(Image.asset("assets/$spritename$i.png"));
    }
  }

  void update();
  void move();

  Widget build();
}
