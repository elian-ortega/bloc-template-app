import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../base_bloc.dart';

import '../../services/authentication_service.dart';
import '../../services/dialog_service.dart';

import '../../locator.dart';
import '../../services/navigation_service.dart';
import '../../ui/router.dart';

class SignUpBloc extends BaseBloc {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  /*
  * UI
   */

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final String _title = 'SignUp';
  String get title => _title;

  String _fullName;
  String get fullName => _fullName;
  void setName(String value) {
    _fullName = value;
    notifyListeners();
  }

  String _email;
  String get email => _email;
  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  String _password;
  String get password => _password;
  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void navigateToLogIn() {
    _navigationService.replaceWith(Routes.login);
  }

  Future<void> createUserWithEmail() async {
    _formKey.currentState.save();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      await _createUserWithEmailHelper(
          email: _email, password: _password, fullName: _fullName);
    }
  }

  /*
  * Actual Logic
   */

  Future _createUserWithEmailHelper({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setBusy = true;
    var authResult = await _authenticationService.createUserWithEmail(
      fullName: fullName,
      email: email,
      password: password,
    );
    setBusy = false;

    if (authResult is bool) {
      if (authResult) {
        await _navigationService.replaceWith(Routes.home);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failed!',
          description:
              'There was an error while signing up please try again later.',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failed!',
        description: authResult,
      );
    }
  }
}
