import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  const MyPlayer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        "imgs/player.png"
      ),
    );
  }
}