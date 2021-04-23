import 'package:flutter/material.dart';

class User with ChangeNotifier {
  int _highScore = 0;

  int get highScore {
    return _highScore;
  }

  void changeHighScore(newScore) {
    _highScore = newScore;
    notifyListeners();
  }
}
