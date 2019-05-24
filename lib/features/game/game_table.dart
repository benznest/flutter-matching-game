import 'dart:math';

import 'package:flutter_match_animal_game/models/block.dart';
import 'package:flutter_match_animal_game/models/coordinate.dart';
import 'package:flutter_match_animal_game/game_config.dart';
import 'package:flutter_match_animal_game/features/game/game_table_calculation.dart';
import 'package:flutter_match_animal_game/features/block/block_manager.dart';

enum BorderSide { NONE, LEFT, TOP, RIGHT, BOTTOM }

class LineMatchResult {
  bool available;
  Coordinate a;
  Coordinate b;
  Coordinate c;
  Coordinate d;

  LineMatchResult({this.a, this.b, this.c, this.d, this.available = false});
}

class GameTable {
  int countRow;
  int countCol;
  double blockSize;
  double blockMargin;
  int countRenovate;
  List<List<Block>> tableData;
  GameTableCalculation gameTableCalculation;
  int countBlock;

  GameTable(
      {this.countRow = GameConfig.COUNT_ROW_DEFAULT,
      this.countCol = GameConfig.COUNT_COL_DEFAULT,
      this.blockSize = GameConfig.BLOCK_SIZE_DEFAULT,
      this.blockMargin = GameConfig.BLOCK_MARGIN_DEFAULT,
      this.countRenovate = GameConfig.COUNT_RENOVATE_DEFAULT});

  void init() {
    initTable();
  }

  void initTable({bool isRandom = true, int value = 1}) {
    countBlock = (countRow - 1) * (countCol - 1);
    tableData = List();
    for (int row = 0; row < countRow; row++) {
      List<Block> listBlock = List();
      for (int col = 0; col < countCol; col++) {
        if (isOuterBlock(Coordinate(row: row, col: col))) {
          listBlock.add(BlockManager.getEmptyBlock());
        } else {
          if (isRandom) {
            listBlock.add(BlockManager.randomBlock());
          } else {
            listBlock.add(BlockManager.getBlock(value));
          }
        }
      }
      tableData.add(listBlock);
    }
  }

  removeBlock(Coordinate coor) {
    if (coor != null) {
      tableData[coor.row][coor.col] = BlockManager.getEmptyBlock();
    }
  }

  bool isOuterBlock(Coordinate coor) {
    return coor.row == 0 ||
        coor.row == countRow - 1 ||
        coor.col == 0 ||
        coor.col == countCol - 1;
  }

  bool isBorderBlock(Coordinate coor) {
    return coor.row == 1 ||
        coor.row == countRow - 2 ||
        coor.col == 1 ||
        coor.col == countCol - 2;
  }

  bool isBlockEmpty(Coordinate coor) {
    return getTableValue(Coordinate(row: coor.row, col: coor.col)) == 0;
  }

  BorderSide getBorderSideBlock(Coordinate source, Coordinate target) {
    if (source.row == 1 && target.row == 1) {
      return BorderSide.TOP;
    } else if (source.row == countRow - 2 && target.row == countRow - 2) {
      return BorderSide.BOTTOM;
    } else if (source.col == 1 && target.col == 1) {
      return BorderSide.LEFT;
    } else if (source.col == countCol - 2 && target.col == countCol - 2) {
      return BorderSide.RIGHT;
    }
    return BorderSide.NONE;
  }

  bool isPathAttachBlock(Coordinate source, Coordinate target) {
    if (source.row == target.row) {
      if (source.col + 1 == target.col || source.col - 1 == target.col) {
        return true;
      }
    } else if (source.col == target.col) {
      if (source.row + 1 == target.row || source.row - 1 == target.row) {
        return true;
      }
    }

    return false;
  }

  bool isBlockInSameAxis(Coordinate source, Coordinate target) {
    return source.row == target.row || source.col == target.col;
  }

  int getTableValue(Coordinate coor) {
    return tableData[coor.row][coor.col].value;
  }

  bool isValueMatch(Coordinate source, Coordinate target) {
    return getTableValue(source) == getTableValue(target);
  }

  LineMatchResult checkBlockMatch(Coordinate source, Coordinate target) {
    if (isValueMatch(source, target)) {
      gameTableCalculation = GameTableCalculation(this);
      if (isPathAttachBlock(source, target)) {
        return gameTableCalculation.makePathAttachCase(source, target);
      } else if (isPathOnBorder(source, target)) {
        return gameTableCalculation.makePathBorderCase(source, target);
      } else {
        // For case L and U
        gameTableCalculation.prepareCalculation();
        gameTableCalculation.calculatePossiblePath(source, target);

        if (gameTableCalculation.isPathL()) {
          return gameTableCalculation.makePathL(source, target);
        } else {
          gameTableCalculation.calculatePathU();
          if (gameTableCalculation.isPathU()) {
            return gameTableCalculation.makePathU(source, target);
          }
        }
      }
    } else {
      print("value block is not match.");
    }

    LineMatchResult result = LineMatchResult();
    return result;
  }

  bool isPathOnBorder(Coordinate source, Coordinate target) {
    return isBorderBlock(source) &&
        isBorderBlock(target) &&
        isBlockInSameAxis(source, target);
  }

  void renovate() {
    for (int row = 1; row < countRow - 1; row++) {
      for (int col = 1; col < countCol - 1; col++) {
        Coordinate coor = Coordinate(row: row, col: col);
        if (!isBlockEmpty(coor)) {
          tableData[row][col] = BlockManager.randomBlock();
        }
      }
    }
  }

  bool canRenovate() {
    return countRenovate > 0;
  }
}
