import 'package:flutter/material.dart';

class TimerInfo extends ChangeNotifier {
  int _remainingtime = 60;

  int get remainingTime => _remainingtime;

  void updateRemainingTime() {
    _remainingtime--;
    notifyListeners();
  }
}
