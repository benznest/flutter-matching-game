import 'package:flutter_match_animal_game/models/coordinate.dart';
import 'package:flutter_match_animal_game/features/game/game_table.dart';

enum MarkPathStatus { DONE, VISIT_INTERSECTION, FAIL }
enum CoordinateType { NORMAL, SOURCE, TARGET }

class IntersectionPoint {
  Coordinate a;
  Coordinate b;

  IntersectionPoint({this.a, this.b});

  bool isOnlyA() {
    return a != null && b == null;
  }

  bool isBothAvailable() {
    return a != null && b != null;
  }
}

class GameTableCalculation {
  GameTable gameTable;
  List<List<bool>> tableCoordinateCalculationTempSource;
  List<Coordinate> listCoordinateCalculationTempSource;
  List<List<bool>> tableCoordinateCalculationTempTarget;
  List<Coordinate> listCoordinateCalculationTempTarget;

  // For case U inside table.
  IntersectionPoint intersectionPoint;

  GameTableCalculation(this.gameTable);

  void prepareCalculation() {
    intersectionPoint = IntersectionPoint();
    listCoordinateCalculationTempSource = List();
    tableCoordinateCalculationTempSource = List();
    tableCoordinateCalculationTempTarget = List();
    listCoordinateCalculationTempTarget = List();

    for (int row = 0; row < gameTable.countRow; row++) {
      List<bool> listSource = List();
      List<bool> listTarget = List();
      for (int col = 0; col < gameTable.countCol; col++) {
        listSource.add(false);
        listTarget.add(false);
      }

      tableCoordinateCalculationTempSource.add(listSource);
      tableCoordinateCalculationTempTarget.add(listTarget);
    }
  }

  bool isPathL() {
    return intersectionPoint.isOnlyA();
  }

  bool isPathU() {
    return intersectionPoint.isBothAvailable();
  }

  LineMatchResult makePathL(Coordinate source, Coordinate target) {
    LineMatchResult result = LineMatchResult();
    if (intersectionPoint.isOnlyA()) {
      result.a = source;
      result.b = intersectionPoint.a;
      result.c = target;
      result.available = true;
    }
    return result;
  }

  LineMatchResult makePathU(Coordinate source, Coordinate target) {
    LineMatchResult result = LineMatchResult();
    if (intersectionPoint.isBothAvailable()) {
      result.a = source;
      result.b = intersectionPoint.a;
      result.c = intersectionPoint.b;
      result.d = target;
      result.available = true;
    }
    return result;
  }

  LineMatchResult makePathAttachCase(Coordinate source, Coordinate target) {
    LineMatchResult result = LineMatchResult();
    result.a = source;
    result.b = target;
    result.available = true;
    return result;
  }

  LineMatchResult makePathBorderCase(Coordinate source, Coordinate target) {
    LineMatchResult result = LineMatchResult();
    BorderSide borderSide = gameTable.getBorderSideBlock(source, target);
    result.a = Coordinate.of(source);
    if (borderSide == BorderSide.TOP) {
      result.b = Coordinate.of(source, addRow: -1);
      result.c = Coordinate.of(target, addRow: -1);
    } else if (borderSide == BorderSide.LEFT) {
      result.b = Coordinate.of(source, addCol: -1);
      result.c = Coordinate.of(target, addCol: -1);
    } else if (borderSide == BorderSide.BOTTOM) {
      result.b = Coordinate.of(source, addRow: 1);
      result.c = Coordinate.of(target, addRow: 1);
    } else if (borderSide == BorderSide.RIGHT) {
      result.b = Coordinate.of(source, addCol: 1);
      result.c = Coordinate.of(target, addCol: 1);
    }

    result.d = Coordinate.of(target);
    result.available = true;
    return result;
  }

  void calculatePossiblePath(Coordinate source, Coordinate target) {
    markPath(source, coorType: CoordinateType.SOURCE);
    markPath(target, coorType: CoordinateType.TARGET);
  }

  CoordinateAxis inverseCoordinateAxis(CoordinateAxis axis) {
    if (axis == CoordinateAxis.Y) {
      return CoordinateAxis.X;
    } else if (axis == CoordinateAxis.X) {
      return CoordinateAxis.Y;
    }
    return CoordinateAxis.NONE;
  }

  void calculatePathU() {
    for (Coordinate coor in listCoordinateCalculationTempSource) {
      coor.printData();
    }

    for (Coordinate coor in listCoordinateCalculationTempSource) {
      if (coor.axis != CoordinateAxis.NONE) {
        Coordinate coorIntersection =
            seekPathBetweenTarget(coor, axis: inverseCoordinateAxis(coor.axis));
        if (coorIntersection != null) {
          intersectionPoint.a = coor;
          intersectionPoint.b = coorIntersection;
          return;
        }
      }
    }
  }

  Coordinate markPath(Coordinate coor,
      {CoordinateAxis axis = CoordinateAxis.NONE,
      CoordinateType coorType = CoordinateType.SOURCE}) {
    if (axis == CoordinateAxis.NONE || axis == CoordinateAxis.Y) {
      for (int row = coor.row - 1; row >= 0; row--) {
        Coordinate subCoor = Coordinate(row: row, col: coor.col);

        MarkPathStatus status =
            markCoordinateOnPath(subCoor, CoordinateAxis.Y, coorType);
        if (status == MarkPathStatus.FAIL) {
          break;
        } else if (status == MarkPathStatus.VISIT_INTERSECTION) {
          return subCoor;
        }
      }

      for (int row = coor.row + 1; row < gameTable.countRow; row++) {
        Coordinate subCoor = Coordinate(row: row, col: coor.col);
        MarkPathStatus status =
            markCoordinateOnPath(subCoor, CoordinateAxis.Y, coorType);
        if (status == MarkPathStatus.FAIL) {
          break;
        } else if (status == MarkPathStatus.VISIT_INTERSECTION) {
          return subCoor;
        }
      }
    }

    if (axis == CoordinateAxis.NONE || axis == CoordinateAxis.X) {
      for (int col = coor.col - 1; col >= 0; col--) {
        Coordinate subCoor = Coordinate(row: coor.row, col: col);
        MarkPathStatus status =
            markCoordinateOnPath(subCoor, CoordinateAxis.X, coorType);
        if (status == MarkPathStatus.FAIL) {
          break;
        } else if (status == MarkPathStatus.VISIT_INTERSECTION) {
          return subCoor;
        }
      }

      for (int col = coor.col + 1; col < gameTable.countCol; col++) {
        Coordinate subCoor = Coordinate(row: coor.row, col: col);
        MarkPathStatus status =
            markCoordinateOnPath(subCoor, CoordinateAxis.X, coorType);
        if (status == MarkPathStatus.FAIL) {
          break;
        } else if (status == MarkPathStatus.VISIT_INTERSECTION) {
          return subCoor;
        }
      }
    }

    return null;
  }

  MarkPathStatus markCoordinateOnPath(
      Coordinate subCoor, CoordinateAxis axis, CoordinateType coorType) {
    if (gameTable.isBlockEmpty(subCoor)) {
      if (isIntersectionOnSourcePath(subCoor)) {
        intersectionPoint.a = Coordinate.ofAxis(subCoor, axis);
        return MarkPathStatus.VISIT_INTERSECTION;
      } else {
        if (coorType == CoordinateType.SOURCE) {
          markTableTempSource(subCoor, axis);
        } else if (coorType == CoordinateType.TARGET) {
          markTableTempTarget(subCoor, axis);
        }
        return MarkPathStatus.DONE;
      }
    } else {
      return MarkPathStatus.FAIL;
    }
  }

  bool isIntersectionOnSourcePath(Coordinate coor) {
    return tableCoordinateCalculationTempSource[coor.row][coor.col];
  }

  markTableTempSource(Coordinate coor, CoordinateAxis axis) {
    tableCoordinateCalculationTempSource[coor.row][coor.col] = true;
    listCoordinateCalculationTempSource.add(Coordinate.ofAxis(coor, axis));
  }

  markTableTempTarget(Coordinate coor, CoordinateAxis axis) {
    tableCoordinateCalculationTempTarget[coor.row][coor.col] = true;
    listCoordinateCalculationTempTarget.add(Coordinate.ofAxis(coor, axis));
  }

  Coordinate seekPathBetweenTarget(Coordinate coor,
      {CoordinateAxis axis = CoordinateAxis.NONE}) {
    if (axis == CoordinateAxis.NONE || axis == CoordinateAxis.Y) {
      for (int row = coor.row - 1; row >= 0; row--) {
        Coordinate subCoor = Coordinate(row: row, col: coor.col);
        if (gameTable.isBlockEmpty(subCoor)) {
          if (isInTargetTemp(subCoor)) {
            return subCoor;
          }
        } else {
          break;
        }
      }

      for (int row = coor.row + 1; row < gameTable.countRow; row++) {
        Coordinate subCoor = Coordinate(row: row, col: coor.col);
        if (gameTable.isBlockEmpty(subCoor)) {
          if (isInTargetTemp(subCoor)) {
            return subCoor;
          }
        } else {
          break;
        }
      }
    }

    if (axis == CoordinateAxis.NONE || axis == CoordinateAxis.X) {
      for (int col = coor.col - 1; col >= 0; col--) {
        Coordinate subCoor = Coordinate(row: coor.row, col: col);
        if (gameTable.isBlockEmpty(subCoor)) {
          if (isInTargetTemp(subCoor)) {
            return subCoor;
          }
        } else {
          break;
        }
      }

      for (int col = coor.col + 1; col < gameTable.countCol; col++) {
        Coordinate subCoor = Coordinate(row: coor.row, col: col);
        if (gameTable.isBlockEmpty(subCoor)) {
          if (isInTargetTemp(subCoor)) {
            return subCoor;
          }
        } else {
          break;
        }
      }
    }

    return null;
  }

  bool isInTargetTemp(Coordinate coor) {
    for (Coordinate subCoor in listCoordinateCalculationTempTarget) {
      print("------");
      print(
          "coor [${coor.row},${coor.col}] == ${subCoor.row},${subCoor.col}] ");
      if (coor.equals(subCoor)) {
        return true;
      }
    }
    return false;
  }
}
