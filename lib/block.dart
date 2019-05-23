import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/coordinate.dart';

class Block {
  int value;
  Color color;

  Block({this.value = 0, this.color});

  Block.of(Block data) {
    value = data.value;
    color = data.color;
  }
}
