import 'package:flutter/material.dart';
import 'package:tapgame/screen.dart';
import 'package:tapgame/tictac.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlayerNameScreen(),
    );
  }
}


