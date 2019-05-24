import 'package:flutter/material.dart';
import 'package:flutter_match_animal_game/ui/screens/game_menu_screen.dart';
import 'package:flutter_match_animal_game/ui/screens/game_play_screen.dart';
import 'package:flutter_match_animal_game/my_application.dart';

void main() {
  MyApplication.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onet Game'.toUpperCase(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameMenuScreen(title: 'Onet Game'.toUpperCase()),
    );
  }
}
