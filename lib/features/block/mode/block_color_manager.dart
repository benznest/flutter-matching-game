import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/game_config.dart';
import 'package:flutter_match_animal_game/models/block.dart';

class BlockColorManager {
  static List<Block> listBlockColor = List();
  static String icon = GameConfig.BASE_ASSET_PATH + "ic_color.png";

  static init() {
    listBlockColor = List()
      ..add(Block(value: 0, color: Colors.transparent)) //
      ..add(Block(value: 1, color: Colors.blue[300])) //
      ..add(Block(value: 2, color: Colors.red[300])) //
      ..add(Block(value: 3, color: Colors.green[300])) //
      ..add(Block(value: 4, color: Colors.purple[300])) //
      ..add(Block(value: 5, color: Colors.orange[300])); //
  }
}