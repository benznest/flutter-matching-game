import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/models/coordinate.dart';

class Block {
  int value;
  Color color;
  String asset;

  Block({this.value = 0, this.color, this.asset});

  Block.of(Block data) {
    value = data.value;
    color = data.color;
    asset = data.asset;
  }

  isColorBlock(){
    return color != null;
  }

  isImageBlock(){
    return asset != null;
  }


}
