import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/features/block/mode/block_animal_manager.dart';
import 'package:flutter_match_animal_game/features/block/mode/block_color_manager.dart';
import 'package:flutter_match_animal_game/features/block/mode/block_people_manager.dart';
import 'package:flutter_match_animal_game/models/block.dart';
import 'package:flutter_match_animal_game/utils/my_utils.dart';

enum BlockMode {
  COLOR,
  ANIMAL,
  PEOPLE
}

class BlockManager {
  static BlockMode blockMode;
  static List<Block> listBlockData = List();

  static init() {
    BlockColorManager.init();
    BlockAnimalManager.init();
    BlockPeopleManager.init();

    setBlockMode(BlockMode.COLOR);
  }

  static void setBlockMode(BlockMode mode) {
    blockMode = mode;
    if (mode == BlockMode.COLOR) {
      listBlockData = BlockColorManager.listBlockColor;
    } else if (mode == BlockMode.ANIMAL) {
      listBlockData = BlockAnimalManager.listBlockAnimal;
    } else if (mode == BlockMode.PEOPLE) {
      listBlockData = BlockPeopleManager.listBlockPeople;
    }
  }

  static String getBlockModeName(BlockMode mode) {
    if (mode == BlockMode.COLOR) {
      return BlockColorManager.nameMode;
    } else if (mode == BlockMode.ANIMAL) {
      return BlockAnimalManager.nameMode;
    } else if (mode == BlockMode.PEOPLE) {
      return BlockPeopleManager.nameMode;
    }
    return "";
  }

  static String getIconBlockMode(BlockMode mode) {
    if (mode == BlockMode.COLOR) {
      return BlockColorManager.icon;
    } else if (mode == BlockMode.ANIMAL) {
      return BlockAnimalManager.icon;
    } else if (mode == BlockMode.PEOPLE) {
      return BlockPeopleManager.icon;
    }
    return null;
  }

  static Block getBlock(int value) {
    return Block.of(listBlockData[value]);
  }

  static Block getEmptyBlock() {
    return Block.of(listBlockData[0]);
  }

  static Block randomBlock() {
    return BlockManager.getBlock(MyUtils.randomInt(min: 1, max: listBlockData.length -1));
  }


}
