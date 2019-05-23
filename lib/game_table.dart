import 'dart:math';

import 'package:flutter_match_animal_game/block.dart';
import 'package:flutter_match_animal_game/block_manager.dart';
import 'package:flutter_match_animal_game/coordinate.dart';
import 'package:flutter_match_animal_game/game_config.dart';

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
  List<List<Block>> tableData;
  List<List<bool>> tableTempCalculation;

  GameTable(
      {this.countRow = GameConfig.COUNT_ROW_DEFAULT,
      this.countCol = GameConfig.COUNT_COL_DEFAULT,
      this.blockSize = GameConfig.BLOCK_SIZE_DEFAULT,
      this.blockMargin = GameConfig.BLOCK_MARGIN_DEFAULT});

  void init() {
    initTable();
  }

  void initTable() {
    tableData = List();
    for (int row = 0; row < countRow; row++) {
      List<Block> listBlock = List();
      for (int col = 0; col < countCol; col++) {
        if (isOuterBlock(Coordinate(row: row, col: col))) {
          listBlock.add(BlockManager.getEmptyBlock());
        } else {
          listBlock.add(BlockManager.randomBlock());
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

  void prepareCalculation() {
    tableTempCalculation = List();
    for (int row = 0; row < countRow; row++) {
      List<bool> list = List();
      for (int col = 0; col < countCol; col++) {
        list.add(false);
      }
      tableTempCalculation.add(list);
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

  bool isAttach(Coordinate source, Coordinate target) {
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
    LineMatchResult result = LineMatchResult();
    if (isValueMatch(source, target)) {
      prepareCalculation();

      if (isAttach(source, target)) {
        result.a = source;
        result.b = target;
        result.available = true;
        return result;
      } else if (isBorderBlock(source) &&
          isBorderBlock(target) &&
          isBlockInSameAxis(source, target)) {
        // border case
        BorderSide borderSide = getBorderSideBlock(source, target);
        result.a = Coordinate.of(source);
        if (borderSide == BorderSide.TOP) {
          result.b = Coordinate.of(source, addRow: -1);
          result.c = Coordinate.of(target, addRow: -1);
        }
        result.d = Coordinate.of(target);
        result.available = true;
        return result;
      }
    } else {
      print("value block is not match.");
    }
    return result;
  }

  calculate(Coordinate source, Coordinate target) {
    calculatePath(source);
    calculatePath(target, isTarget: true);
  }

  void calculatePath(Coordinate coor, {bool isTarget = false}) {
    for (int row = coor.row; row >= 0; row--) {
      if (getTableValue(Coordinate(row: row, col: coor.col)) == 0) {
        if (tableTempCalculation[row][coor.col]) {
        } else {
          tableTempCalculation[row][coor.col] = true;
        }
      } else {
        break;
      }
    }

    for (int row = coor.row; row < countRow; row++) {
      if (getTableValue(Coordinate(row: row, col: coor.col)) == 0) {
        tableTempCalculation[row][coor.col] = true;
      } else {
        break;
      }
    }

    for (int col = coor.col; col >= 0; col--) {
      if (getTableValue(Coordinate(row: col, col: coor.col)) == 0) {
        tableTempCalculation[coor.row][col] = true;
      } else {
        break;
      }
    }

    for (int col = coor.col; col < countCol; col++) {
      if (getTableValue(Coordinate(row: col, col: coor.col)) == 0) {
        tableTempCalculation[coor.row][col] = true;
      } else {
        break;
      }
    }
  }
}
