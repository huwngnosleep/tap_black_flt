import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthForm extends StatefulWidget {
  final int score;
  final int size;

  AuthForm({@required this.score, @required this.size});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isLoading = false;
  String name = '';

  @override
  Widget build(BuildContext context) {
    void _submit() async {
      setState(() {
        _isLoading = true;
      });
      if(widget.score < 10) {
        setState(() {
          _isLoading = false;
        });
        return showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text('Achieve at least 10 points to save your result!')));
      }
      if(name.trim().length == 0) {
        setState(() {
          _isLoading = false;
        });
        return showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text('Please enter your name!')));
      }
      var url = Uri.parse(
          'https://taptheblack-huwngnosleep-default-rtdb.firebaseio.com/high-score/${widget.size}x${widget.size}.json');
      var response = await http.post(url,
          body: json.encode({'name': name, 'score': widget.score}));

      if (response.statusCode != 200) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text('Something went wrong, check your connection!')));
      }

      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 20,
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    },
                    child: Text(
                      'Okay',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20),
                    )),
              ],
              title: Text('Uploading completed!')));
    }

    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red[400].withOpacity(0.8),
                  border: Border.all(
                      width: 6, color: Theme.of(context).buttonColor)),
              child: TextField(
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLength: 16,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(
                    counterText: '',
                    hintText: 'Name',
                    hintStyle:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    focusColor: Colors.black,
                    focusedBorder: null),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).backgroundColor),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: _isLoading
                        ? ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).buttonColor),
                            ),
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColorDark),
                            ))
                        : ElevatedButton(
                            onPressed: _submit,
                            child: Text('Save',
                                style: TextStyle(color: Colors.black))),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
