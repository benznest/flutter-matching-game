import 'package:flutter_match_animal_game/coordinate.dart';
import 'package:flutter_match_animal_game/game_table.dart';

enum MarkPathStatus {
  DONE,
  VISIT_INTERSECTION,
  FAIL
}

class GameTableCalculation {
  GameTable gameTable;
  List<List<bool>> tableCoordinateCalculationTempSource;
  List<Coordinate> listCoordinateCalculationTempSource;
  Coordinate coordinateIntersectionL;


  GameTableCalculation(this.gameTable);

  void prepareCalculation() {
    coordinateIntersectionL = null;
    listCoordinateCalculationTempSource = List();
    tableCoordinateCalculationTempSource = List();
    for (int row = 0; row < gameTable.countRow; row++) {
      List<bool> list = List();
      for (int col = 0; col < gameTable.countCol; col++) {
        list.add(false);
      }
      tableCoordinateCalculationTempSource.add(list);
    }
  }

  LineMatchResult calculatePathL(Coordinate source, Coordinate target) {
    markPath(source);
    markPath(target);

    LineMatchResult result = LineMatchResult();
    if (coordinateIntersectionL != null) {
      result.a = source;
      result.b = coordinateIntersectionL;
      result.c = target;
      result.available = true;
    }
    return result;
  }

  void markPath(Coordinate coor) {
    for (int row = coor.row -1; row >= 1; row--) {
      Coordinate subCoor = Coordinate(row: row, col: coor.col);
      MarkPathStatus status = markCoordinateOnPath(subCoor);
      if (status == MarkPathStatus.FAIL) {
        break;
      } else if (status == MarkPathStatus.VISIT_INTERSECTION) {
        return;
      }
    }

    for (int row = coor.row + 1; row < gameTable.countRow - 1; row++) {
      print("$row , ${coor.col}");
      Coordinate subCoor = Coordinate(row: row, col: coor.col);
      MarkPathStatus status = markCoordinateOnPath(subCoor);
      if (status == MarkPathStatus.FAIL) {
        break;
      } else if (status == MarkPathStatus.VISIT_INTERSECTION) {
        return;
      }
    }

    for (int col = coor.col - 1; col >= 1; col--) {
      Coordinate subCoor = Coordinate(row: coor.row, col: col);
      MarkPathStatus status = markCoordinateOnPath(subCoor);
      if (status == MarkPathStatus.FAIL) {
        break;
      } else if (status == MarkPathStatus.VISIT_INTERSECTION) {
        return;
      }
    }

    for (int col = coor.col + 1; col < gameTable.countCol - 1; col++) {
      Coordinate subCoor = Coordinate(row: coor.row, col: col);
      MarkPathStatus status = markCoordinateOnPath(subCoor);
      if (status == MarkPathStatus.FAIL) {
        break;
      } else if (status == MarkPathStatus.VISIT_INTERSECTION) {
        return;
      }
    }
  }

  MarkPathStatus markCoordinateOnPath(Coordinate subCoor) {
    if (!gameTable.isOuterBlock(subCoor) && gameTable.isBlockEmpty(subCoor)) {
      if (isIntersectionOnSourcePath(subCoor)) {
        coordinateIntersectionL = Coordinate.of(subCoor);
        return MarkPathStatus.VISIT_INTERSECTION;
      } else {
        markTableTempSource(subCoor);
        listCoordinateCalculationTempSource.add(subCoor);
        return MarkPathStatus.DONE;
      }
    } else {
      return MarkPathStatus.FAIL;
    }
  }

  bool isIntersectionOnSourcePath(Coordinate coor) {
    return tableCoordinateCalculationTempSource[coor.row][coor.col];
  }

  markTableTempSource(Coordinate coor) {
    tableCoordinateCalculationTempSource[coor.row][coor.col] = true;
  }


}