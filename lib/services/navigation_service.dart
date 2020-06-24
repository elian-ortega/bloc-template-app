import 'package:flutter/material.dart';

class NavigationService {
  final _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    _navigationKey.currentState.pop();
  }

  Future<Object> navigateTo(String routeName, {Object arguments}) {
    return _navigationKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<Object> replaceWith(String routeName, {Object arguments}) {
    return _navigationKey.currentState.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }
}
