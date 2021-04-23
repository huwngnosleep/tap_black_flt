import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_the_black/providers/user.dart';
import 'package:tap_the_black/screens/game_result_screen.dart';
import 'package:tap_the_black/widgets/game/blocks_grid.dart';
import 'package:tap_the_black/widgets/game/score_chart.dart';
import 'package:tap_the_black/widgets/ui/custom_button.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/gamescreen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _blockNumber = 9;
  int _score = 0;
  int _highScore = 0;
  int _time = 3000;
  var _timer;

  List<int> _blockKeys = [];

  void suffleBlocks(Timer _timer) {
    setState(() {
      _blockKeys.shuffle();
    });
  }


  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _blockNumber; i++) {
      _blockKeys.add(i);
    }

    _timer = new Timer.periodic(Duration(milliseconds: _time), suffleBlocks);
  }

  void _chooseHandler(value) {
    if (value == true) {
      _timer.cancel();
      setState(() {
        _score++;
        if (_time > 200) {
          _time -= 50;
        }
      });
      suffleBlocks(_timer);
      if (_score % 2 == 0) {
        new Timer.periodic(Duration(milliseconds: _time), suffleBlocks);
      }
      if (_score > _highScore) {
        Provider.of<User>(context, listen: false).changeHighScore(_score);
      }
    } else {
      Navigator.pushNamed(
        context,
        GameResultScreen.routeName,
        arguments: {'score': _score, 'size': sqrt(_blockNumber).toInt()},
      );
      setState(() {
        _score = 0;
        _time = 3000;
        _timer.cancel();
      });
    }
  }

  void _replayHandler() {
    Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _highScore = Provider.of<User>(context).highScore;
    });
    var spacing;
    switch (_blockNumber) {
      case 9:
        spacing = MediaQuery.of(context).size.width * 0.07;
        break;
      case 16:
        spacing = MediaQuery.of(context).size.width * 0.04;
        break;
      case 25:
        spacing = MediaQuery.of(context).size.width * 0.01;
        break;
      default:
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      CustomButton(
                        icon: Icon(Icons.arrow_back),
                        onPress: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CustomButton(
                        icon: Icon(Icons.cached),
                        onPress: _replayHandler,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration:
                            BoxDecoration(color: Theme.of(context).buttonColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: DropdownButton(
                            value: sqrt(_blockNumber).toInt(),
                            icon: const Icon(Icons.arrow_downward),
                            dropdownColor: Theme.of(context).buttonColor,
                            iconSize: 20,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w500),
                            elevation: 10,
                            underline: null,
                            onChanged: (int newValue) {
                              List<int> newBlockKeys = [];
                              for (int i = 0; i < newValue * newValue; i++) {
                                newBlockKeys.add(i);
                              }
                              setState(() {
                                _blockNumber = newValue * newValue;
                                _blockKeys = newBlockKeys;
                                _score = 0;
                                _time = 3000;
                                _timer.cancel();
                              });
                            },
                            items: <int>[3, 4, 5]
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('${value}x${value}'),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ScoreChart(_score),
            ),
            Expanded(
              flex: 6,
              child: Center(
                child: Card(
                  shadowColor: Colors.black,
                  elevation: 15,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).backgroundColor),
                    height: MediaQuery.of(context).size.width * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BlocksGrid(blockKeys: _blockKeys, blockNumber: _blockNumber, spacing: spacing, chooseHandler: _chooseHandler),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
