import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../base_bloc.dart';
import '../../locator.dart';

import '../../services/authentication_service.dart';
import '../../services/dialog_service.dart';
import '../../services/navigation_service.dart';

import '../../ui/router.dart';

class LogInBloc extends BaseBloc {
  static final _navigationService = locator<NavigationService>();
  static final _authenticationService = locator<AuthenticationService>();
  static final _dialogService = locator<DialogService>();

  /*
   * UI
   */

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final String _title = 'LogIn';
  String get title => _title;

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

  void navigateToSignUp() {
    _navigationService.replaceWith(Routes.signup);
  }

  Future logInWithEmail() async {
    _formKey.currentState.save();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      await _logInWithEmailHelper(email: _email, password: _password);
    }
  }

  /*
  * Actual Logic 
  */

  Future _logInWithEmailHelper({
    @required String email,
    @required String password,
  }) async {
    setBusy = true;
    var authResult = await _authenticationService.logInWithEmail(
        email: email, password: password);
    setBusy = false;

    if (authResult is bool) {
      if (authResult) {
        await _navigationService.replaceWith(Routes.home);
      } else {
        await _dialogService.showDialog(
          title: 'Log In Failed',
          description:
              'There was a problem while loggin in. Please try again later!',
          buttonTitle: 'Ok',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Log In Failed',
        description: authResult,
        buttonTitle: 'Ok',
      );
    }
  }
}
