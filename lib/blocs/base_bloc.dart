import 'package:flutter/material.dart';

class BaseBloc extends ChangeNotifier {
  bool _busy = false;
  bool get isBusy => _busy;

  set setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
