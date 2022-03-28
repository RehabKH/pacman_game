import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pacman_game/myPixel.dart';
import 'package:pacman_game/path.dart';
import 'package:pacman_game/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;
  int player = numberInRow * 15 + 1;
  List<int> food = [];
  int score = 0;
  bool mouseClosed = false;
  int ghost = numberInRow * 2 - 2;
  String ghostDirection = "left";
  List<int> barrieries = [89,91,92,93,94,96,97,30,41,52,63,74,73,72,61,50,39,28,27,26,37,48,59,70,69,68,57,46,35,24
    ,0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    21,
    32,
    43,
    54,
    65,
    76,
    87,
    98,
    109,
    120,
    131,
    142,
    153,
    164,
    175,
    186,
    185,
    184,
    183,
    182,
    181,
    180,
    179,
    178,
    177,
    176,
    165,
    154,
    143,
    132,
    121,
    110,
    99,
    88,
    77,
    66,
    55,
    44,
    33,
    22,
    11,
   162,151,140,129,118,117,116,127,138,149,160,148,147,158,156,145,134,123,112,113,114,125,136
  ];

  String direction = "right";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0) {
                    setState(() {
                      direction = "down";
                    });
                  } else {
                    setState(() {
                      direction = "up";
                    });
                  }
                  print(direction);
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    setState(() {
                      direction = "right";
                    });
                  } else {
                    setState(() {
                      direction = "left";
                    });
                  }
                },
                child: Container(
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: numberOfSquares,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: numberInRow),
                      itemBuilder: (context, index) {
                        if (mouseClosed && player == index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.yellow, shape: BoxShape.circle),
                            ),
                          );
                        } else if (player == index) {
                          switch (direction) {
                            case "left":
                              return Transform.rotate(
                                  angle: pi, child: MyPlayer());

                            case "right":
                              return MyPlayer();

                            case "up":
                              return Transform.rotate(
                                  angle: 3 * pi / 2, child: MyPlayer());
                            case "down":
                              return Transform.rotate(
                                  angle: pi / 2, child: MyPlayer());
                            default:
                              return MyPlayer();
                          }
                        } else if (barrieries.contains(index)) {
                          return MyPixel(Colors.blue[800], Colors.blue[900],
                              Text(""));
                        } else
                          return MyPath(
                              (!food.contains(index))
                                  ? Colors.black
                                  : Colors.yellow,
                              Colors.black,
                              Text(""));
                      }),
                ),
              )),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Score: " + score.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                GestureDetector(
                  onTap: () {
                    startGame();
                  },
                  child: Text("P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  void startGame() {
    getFood();
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      setState(() {
        mouseClosed = !mouseClosed;
      });
      if (food.contains(player)) {
        setState(() {
          food.remove(player);
          score++;
        });
      }
      switch (direction) {
        case "left":
          moveLeft();
          break;
        case "right":
          moveRight();
          break;
        case "up":
          moveUp();
          break;
        case "down":
          moveDown();
          break;
      }
      ;
    });
  }

  moveUp() {
    if (!barrieries.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  moveDown() {
    if (!barrieries.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  moveLeft() {
    if (!barrieries.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  moveRight() {
    if (!barrieries.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barrieries.contains(i)) {
        setState(() {
          food.add(i);
        });
      }
    }
  }
}
