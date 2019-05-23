import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/block.dart';
import 'package:flutter_match_animal_game/game_config.dart';

class BlockManager {
  static List<Block> listBlockType = List();

  static init() {
    listBlockType = List()
      ..add(Block(value: 0, color: Colors.transparent))
      ..add(Block(value: 1, color: Colors.blue[300]))
      ..add(Block(value: 2, color: Colors.red[300]))
      ..add(Block(value: 3, color: Colors.green[300]))
      ..add(Block(value: 4, color: Colors.purple[300]))
      ..add(Block(value: 5, color: Colors.orange[300]));
  }

  static Block getBlock(int value) {
    return Block.of(listBlockType[value]);
  }

  static Block getEmptyBlock() {
    return Block.of(listBlockType[0]);
  }

  static Block randomBlock() {
    return BlockManager.getBlock(randomInt());
  }

  static int randomInt({int min = 1, int max = 5}) {
    Random random = Random();
    return random.nextInt(max) + min;
  }
}
