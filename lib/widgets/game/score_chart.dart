import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_the_black/providers/user.dart';

class ScoreChart extends StatefulWidget {
  final int score;

  ScoreChart(this.score);

  @override
  _ScoreChartState createState() => _ScoreChartState();
}

class _ScoreChartState extends State<ScoreChart> {
  @override
  Widget build(BuildContext context) {
    final highScore = Provider.of<User>(context).highScore;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Score: ${widget.score}',
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'High score: ${highScore}',
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    );
  }
}
