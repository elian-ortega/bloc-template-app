import 'package:bloc_app_template/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../ui/screens/login_screen.dart';
import '../ui/screens/signup_screen.dart';

class Routes {
  static const String login = 'login';
  static const String signup = 'signup';
  static const String home = 'home';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return _getPageRoute(
          routeName: settings.name,
          screen: LogInScreen(),
        );
        break;
      case Routes.signup:
        return _getPageRoute(
          routeName: settings.name,
          screen: SignUpScreen(),
        );
        break;
      case Routes.home:
        return _getPageRoute(
          routeName: settings.name,
          screen: HomeScreen(),
        );
        break;
      default:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Error Loading Screen'),
            ),
          ),
        );
    }
  }

  static PageRoute _getPageRoute({String routeName, Widget screen}) {
    return SlideUpRoute(page: screen);
  }
}

class SlideUpRoute extends PageRouteBuilder {
  final Widget page;

  SlideUpRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
