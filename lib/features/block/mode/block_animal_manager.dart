import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/game_config.dart';
import 'package:flutter_match_animal_game/models/block.dart';

class BlockAnimalManager {
  static List<Block> listBlockAnimal = List();
  static String icon = GameConfig.BASE_ASSET_PATH + "animal/ic_dog.png";

  static init() {
    listBlockAnimal = List()
      ..add(Block(value: 0, asset: GameConfig.BASE_ASSET_PATH + "animal/ic_alligator.png")) //
      ..add(Block(value: 1, asset: GameConfig.BASE_ASSET_PATH + "animal/ic_butterfly.png")) //
      ..add(Block(value: 2, asset: GameConfig.BASE_ASSET_PATH + "animal/ic_dolphin.png")) //
      ..add(Block(value: 3, asset: GameConfig.BASE_ASSET_PATH + "animal/ic_fish.png")) //
      ..add(Block(value: 4, asset: GameConfig.BASE_ASSET_PATH + "animal/ic_panda.png")) //
      ..add(Block(value: 5, asset: GameConfig.BASE_ASSET_PATH + "animal/ic_pug.png")); //
  }
}