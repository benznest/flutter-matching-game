import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/game_config.dart';
import 'package:flutter_match_animal_game/models/block.dart';

class BlockPeopleManager {
  static String nameMode = "People";
  static List<Block> listBlockPeople = List();
  static String icon = GameConfig.BASE_ASSET_PATH + "people/ic_people_1.png";

  static init() {
    listBlockPeople = List()
      ..add(Block(value: 0, asset: GameConfig.BASE_ASSET_PATH + "tranparent.png")) //
      ..add(Block(value: 1, asset: GameConfig.BASE_ASSET_PATH + "people/ic_people_1.png")) //
      ..add(Block(value: 2, asset: GameConfig.BASE_ASSET_PATH + "people/ic_people_2.png")) //
      ..add(Block(value: 3, asset: GameConfig.BASE_ASSET_PATH + "people/ic_people_3.png")) //
      ..add(Block(value: 4, asset: GameConfig.BASE_ASSET_PATH + "people/ic_people_4.png")) //
      ..add(Block(value: 5, asset: GameConfig.BASE_ASSET_PATH + "people/ic_people_5.png")) //
      ..add(Block(value: 6, asset: GameConfig.BASE_ASSET_PATH + "people/ic_people_6.png")) //
      ..add(Block(value: 7, asset: GameConfig.BASE_ASSET_PATH + "people/ic_people_7.png")) //
      ..add(Block(value: 8, asset: GameConfig.BASE_ASSET_PATH + "people/ic_people_8.png")) //
      ..add(Block(value: 9, asset: GameConfig.BASE_ASSET_PATH + "people/ic_people_9.png")); //
  }
}

