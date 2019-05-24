import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameMenuPage extends StatefulWidget {
  GameMenuPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameMenuPageState createState() => _GameMenuPageState();
}

class _GameMenuPageState extends State<GameMenuPage> {
  PageController _pageController = PageController();

  @override
  void initState() {
    // Force landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
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
      appBar: buildAppBar(),
      body: buildBody("Home"),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildBody(String data) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green[100],Colors.yellow[100]],begin: Alignment.topLeft,end: Alignment.bottomRight)) ,
      child: ListView(children: <Widget>[
        Container(
            child: Container(
                padding: EdgeInsets.all(32),
                margin: EdgeInsets.symmetric(vertical: 32,horizontal: 64),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.green[100],
                      offset: Offset(0, 5),
                      blurRadius: 20,
                      spreadRadius: 5)
                ], color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text("Mode".toUpperCase(),
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 4),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 4),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 4),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ],
                    ),
                  )
                ])))
      ]),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton.extended(
      label: Text("Start".toUpperCase()),
      icon: Icon(Icons.check),
      backgroundColor: Colors.orange[300],
      onPressed: () {},
      tooltip: 'Increment',
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.green[200],
      elevation: 0,
      title: Text(widget.title),
      actions: <Widget>[
//        IconButton(icon: Icon(Icons.search), onPressed: () {}),
//        IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
      ],
    );
  }
}
