import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HighScoreChart extends StatefulWidget {
  final int size;
  HighScoreChart(this.size);
  @override
  _HighScoreChartState createState() => _HighScoreChartState();
}

class _HighScoreChartState extends State<HighScoreChart> {
  List users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List loadedData = [];

    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse(
        'https://taptheblack-huwngnosleep-default-rtdb.firebaseio.com/high-score/${widget.size}x${widget.size}.json');
    try {
      var response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((id, dataObject) {
        loadedData
            .add({"name": dataObject["name"], "score": dataObject["score"]});
      });
      setState(() {
        users = loadedData;
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading == true) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColorDark),
        ),
      );
    }

    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return FractionallySizedBox(
            widthFactor: 0.9,
            child: Card(
              margin: const EdgeInsets.only(top: 10),
              elevation: 5,
              child: ListTile(
                leading: Text(
                  '#${index + 1}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                title: Text(
                  '${users[index]["name"]}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Text(
                  '${users[index]["score"]}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          );
        });
  }
}
