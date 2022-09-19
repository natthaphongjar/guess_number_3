import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Game.dart';
import '../alert.dart';
//
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  var Input = "";
  var Output = "ทายเลข 1 ถึง 100";
  var game = Game();
  var index = 0;

  Widget block(int num) {
    var a;
    if (num == -1) {
      a = Icon(
        Icons.clear,
        color: Colors.purple[500],
      );
    } else if (num == -2) {
      a = Icon(Icons.backspace_outlined, color: Colors.purple[500]);
    } else {
      a = Text(
        '$num',
        style: GoogleFonts.sarabun(fontSize: 20, color: Colors.purple[500]),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          if (num == -1) {
            Input = "";
          } else if (num == -2) {
            Input = Input.substring(0, Input.length - 1);
          } else {
            Input = Input + '$num';
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          alignment: Alignment.center,
          width: 60,
          height: 30,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4.0)),
          child: a,
        ),
      ),
    );
  }

  void check() {
    if (Input.length <= 0) {
      showMyDialog(context, "ERROR", "กรุณากรอกตัวเลข");
    } else {
      index++;
      int a = int.tryParse(Input)!;
      var n = game.check(a);
      setState(() {
        Input = "";
        if (n == 0) {
          Output = "$a : ถูกต้อง 🎉(ทาย $index ครั้ง)";
        } else if (n == -1) {
          Output = "$a : น้อยเกินไป";
        } else {
          Output = "$a : มากเกินไป";
        }
      });
    }
  }

  void gameStart() {
    game = Game();
    setState(() {
      Input = "";
      Output = "ทายเลข 1 ถึง 100";
      index = 0;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUESS THE NUMBER'),
        backgroundColor: Colors.purple[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(4, 4))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/01.png',
                    width: 110,
                    height: 180,
                  ),
                  Column(
                    children: [
                      Text(
                        'GUESS',
                        style:
                            TextStyle(fontSize: 36, color: Colors.purple[200]),
                      ),
                      Text(
                        'THE NUMBER',
                        style:
                            TextStyle(fontSize: 18, color: Colors.purple[500]),
                      )
                    ],
                  )
                ],
              ),
              //SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        Input,
                        style: GoogleFonts.sarabun(fontSize: 50),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Output,
                            style: GoogleFonts.sarabun(fontSize: 20),
                          ),
                          ElevatedButton(
                              onPressed: gameStart,
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[50])),
                              child: Icon(Icons.restart_alt_outlined,color: Colors.purple[400],)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      for (var i in [
                        [1, 2, 3],
                        [4, 5, 6],
                        [7, 8, 9],
                        [-1, 0, -2]
                      ])
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [for (var j in i) block(j)],
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                            onPressed: check,
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.purple)),
                            child: Text(
                              'GUESS',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
