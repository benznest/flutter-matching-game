import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/coordinate.dart';
import 'package:flutter_match_animal_game/game_config.dart';
import 'package:flutter_match_animal_game/game_table.dart';
import 'package:flutter_match_animal_game/lines_match_painter.dart';

//
//
//               --------------------------
//               |                        |
//               |                        |  <== BASE_HEIGHT_LINE
//               |                        |
//
//                                           <== BASE_MARGIN_LINE_BLOCK
//
//               []                      []  <== BLOCK
//
//
//
//
class LineMatchBuilder {
  double marginLineFromBlock = 5;
  GameTable gameTable;

  LineMatchBuilder(
      {@required this.gameTable,
      this.marginLineFromBlock = GameConfig
          .MARGIN_LINE_FROM_BLOCK}); //    double BASE_HEIGHT_LINE = 15;

  LinesMatchPainter build(
      {Coordinate a, Coordinate b, Coordinate c, Coordinate d}) {
    Offset offsetA = getCenterOffsetBlock(a);
    Offset offsetB = getCenterOffsetBlock(b);
    Offset offsetC = getCenterOffsetBlock(c);
    Offset offsetD = getCenterOffsetBlock(d);

    return LinesMatchPainter(
        offsetA: offsetA, offsetB: offsetB, offsetC: offsetC, offsetD: offsetD);
  }

  Offset getCenterOffsetBlock(Coordinate coor) {
    if(coor != null) {
      double dx = ((coor.col + 1) * (gameTable.blockMargin * 2)) +
          (coor.col * gameTable.blockSize) +
          (gameTable.blockSize / 2);
      double dy = ((coor.row + 1) * (gameTable.blockMargin * 2)) +
          (coor.row * gameTable.blockSize) +
          (gameTable.blockSize / 2);

      return Offset(dx, dy);
    }
    return null;
  }
}
