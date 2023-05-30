import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Game(),
    );
  }
}

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int userChoice = 0;
  int systemChoice = 0;

  int scoreYou = 0;
  int scoreSystem = 0;
  double turns = 0.0;
  bool isPlay = false;

  void _changeRotation() {
    setState(() => turns += 1.0);
  }

  void play(int choice) {
    isPlay = true;
    userChoice = choice;
    turns += 1.0;
    setState(() => turns += 1.0);
    Timer(Duration(seconds: 1), () {
      setState(() {
        systemChoice = Random().nextInt(3);
        isPlay = false;

        roundWinner();
      });
    });
  }

  void roundWinner() {
    // 0 paper
    // 1 rock
    // 2 scissors

    if (userChoice == 0 && systemChoice == 2 ||
        userChoice == 1 && systemChoice == 0 ||
        userChoice == 2 && systemChoice == 1) {
      scoreSystem++;
    } else if (userChoice != systemChoice) {
      scoreYou++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ROCK PAPER SCISSORS"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedOpacity(
            opacity: isPlay ? 1 : 0,
            // opacity: 1,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: AnimatedScale(
              duration: Duration(milliseconds: 200),
              scale: isPlay ? 1 : 0,
              curve: Curves.easeInOut,
              child: AnimatedRotation(
                turns: turns,
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                child: Column(
                  children: [
                    Image.asset(
                      "images/btn0.png",
                      height: 30,
                      width: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/btn1.png",
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          "images/btn2.png",
                          height: 30,
                          width: 30,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  AnimatedScale(
                      duration: Duration(milliseconds: 200),
                      scale: !isPlay ? 1.0 : 0,
                      curve: Curves.easeInOut,
                      child: Image.asset("images/btn$userChoice.png")),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'You',
                    style: TextStyle(fontSize: 24, color: Colors.blue.shade800),
                  )
                ],
              ),
              Text(
                "vs",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  AnimatedScale(
                      duration: Duration(milliseconds: 200),
                      scale: !isPlay ? 1.0 : 0,
                      curve: Curves.easeInOut,
                      child: Image.asset("images/btn$systemChoice.png")),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'System',
                    style: TextStyle(fontSize: 24, color: Colors.blue.shade800),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  play(0);
                  // _changeRotation();
                },
                child: Image.asset(
                  "images/btn0.png",
                  height: 80,
                  width: 80,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      play(1);
                      // _changeRotation();
                    },
                    child: Image.asset(
                      "images/btn1.png",
                      height: 80,
                      width: 80,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      play(2);
                    },
                    child: Image.asset(
                      "images/btn2.png",
                      height: 80,
                      width: 80,
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 44,
          )
        ],
      ),
    );
  }
}
