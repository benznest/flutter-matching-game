enum CoordinateAxis { NONE, X, Y }

class Coordinate {
  int row;
  int col;
  CoordinateAxis axis;

  Coordinate({this.row = 0, this.col = 0, this.axis = CoordinateAxis.NONE});

  Coordinate.of(Coordinate coor, {int addRow = 0, int addCol = 0}) {
    row = coor.row + addRow;
    col = coor.col + addCol;
    axis = coor.axis;
  }

  Coordinate.ofAxis(Coordinate coor, CoordinateAxis axis) {
    this.row = coor.row;
    this.col = coor.col;
    this.axis = axis;
  }

  bool equals(Coordinate coor) {
    if (coor != null) {
      return row == coor.row && col == coor.col;
    }
    return false;
  }

  printData() {
    print("$row , $col , $axis");
  }
}
