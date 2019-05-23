import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_match_animal_game/block.dart';
import 'package:flutter_match_animal_game/coordinate.dart';
import 'package:flutter_match_animal_game/game_config.dart';
import 'package:flutter_match_animal_game/game_table.dart';
import 'package:flutter_match_animal_game/lines_match_builder.dart';
import 'package:flutter_match_animal_game/lines_match_painter.dart';

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameTable gameTable;
  Coordinate coordinateSelected;
  LinesMatchPainter linesMatchPainter;

  @override
  void initState() {
    gameTable = GameTable(
        countRow: GameConfig.COUNT_ROW_DEFAULT,
        countCol: GameConfig.COUNT_COL_DEFAULT,
        blockSize: GameConfig.BLOCK_SIZE_DEFAULT);
    gameTable.init();

    linesMatchPainter = null;

    // Force landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  bool isSelectedMode() {
    return coordinateSelected != null;
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            child: Container(
                color: Colors.green[100],
                child: Center(
                    child: CustomPaint(
                        painter: linesMatchPainter,
                        child: Container(child: buildGameTable())))),
            onTap: () {
              clear();
            }));
  }

  buildGameTable() {
    List<Row> listRow = List();
    for (int row = 0; row < gameTable.countRow; row++) {
      List<Widget> listBlock = List();
      for (int col = 0; col < gameTable.countCol; col++) {
        Block block = gameTable.tableData[row][col];
        Coordinate coor = Coordinate(row: row, col: col);
        listBlock.add(GestureDetector(
          child: buildBlock(block, isSelected: coor == coordinateSelected),
          onTap: () {
            selectBlock(block, coor);
          },
        ));
      }
      listRow.add(Row(mainAxisSize: MainAxisSize.min, children: listBlock));
    }

    return Column(mainAxisSize: MainAxisSize.min, children: listRow);
  }

  Container buildBlock(Block block, {bool isSelected = false}) {
    if (block.value != 0 && isSelectedMode() && isSelected) {
      return Container(
        margin: EdgeInsets.all(2),
        width: gameTable.blockSize,
        height: gameTable.blockSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: block.color,
        ),
        child: Icon(Icons.check, color: Colors.white),
      );
    } else {
      return Container(
          margin: EdgeInsets.all(2),
          width: gameTable.blockSize,
          height: gameTable.blockSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: block.color,
          ));
    }
  }

  clear() {
    setState(() {
      coordinateSelected = null;
    });
  }

  setCoordinateSelected(Coordinate coor) {
    setState(() {
      coordinateSelected = coor;
    });
  }

  void selectBlock(Block block, Coordinate coor) {
    if (block.value != 0 && isSelectedMode()) {
      LineMatchResult result =
          gameTable.checkBlockMatch(coordinateSelected, coor);
      if (result.available) {
        linesMatchPainter = LineMatchBuilder(gameTable: gameTable).build(
          a: result.a,
          b: result.b,
          c: result.c,
          d: result.d,
        );

        gameTable.removeBlock(result.a);
        gameTable.removeBlock(result.b);
        gameTable.removeBlock(result.c);
        gameTable.removeBlock(result.d);
        clear();

        delay(milli:200,then: () {
          linesMatchPainter = null;
        });
      } else {
        clear();
      }
    } else {
      setCoordinateSelected(coor);
    }
  }

  void delay({int milli = 300, Function then}) {
    Future.delayed(Duration(milliseconds: milli), () {
      if (then != null) {
        setState(() {
          then();
        });
      }
    });
  }
}
