import 'package:flutter/material.dart';
import 'package:pacman_game/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pacman Game',
     debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
