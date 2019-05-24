import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/game_config.dart';
import 'package:flutter_match_animal_game/models/block.dart';

class BlockPeopleManager {
  static List<Block> listBlockPeople = List();
  static String icon = GameConfig.BASE_ASSET_PATH + "people/ic_people.png";

  static init() {
    listBlockPeople = List()
      ..add(Block(value: 0, asset: GameConfig.BASE_ASSET_PATH + "people/ic_pear.png")) //
      ..add(Block(value: 1, asset: GameConfig.BASE_ASSET_PATH + "people/ic_pear.png")) //
      ..add(Block(value: 2, asset: GameConfig.BASE_ASSET_PATH + "people/ic_namneung.png")) //
      ..add(Block(value: 3, asset: GameConfig.BASE_ASSET_PATH + "people/ic_gym.png")) //
      ..add(Block(value: 4, asset: GameConfig.BASE_ASSET_PATH + "people/ic_dream.png")) //
      ..add(Block(value: 5, asset: GameConfig.BASE_ASSET_PATH + "people/ic_benz.png")); //
  }
}