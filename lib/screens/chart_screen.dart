import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tap_the_black/widgets/game/high_score_chart.dart';

class ChartScreen extends StatefulWidget {
  static const routeName = '/chart-screen';
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(
                  text: '3x3',
                ),
                Tab(
                  text: '4x4',
                ),
                Tab(
                  text: '5x5',
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            HighScoreChart(3),
            HighScoreChart(4),
            HighScoreChart(5),
          ]),
        ));
  }
}
