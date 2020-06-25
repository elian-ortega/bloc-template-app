import 'package:bloc_app_template/locator.dart';
import 'package:bloc_app_template/models/user.dart';
import 'package:bloc_app_template/services/authentication_service.dart';
import 'package:flutter/material.dart';

class BaseBloc extends ChangeNotifier {
  static final _authenticationService = locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get isBusy => _busy;

  set setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
