import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'ui/router.dart';
import 'ui/dialogs.dart';

import 'services/navigation_service.dart';
import 'services/dialog_service.dart';

import 'blocs/login_bloc.dart';
import 'blocs/signup_bloc.dart';
import 'blocs/home_bloc.dart';
import 'blocs/startup_bloc.dart';
import 'blocs/addpost_bloc.dart';

void main() {
  setUpLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LogInBloc>(create: (_) => LogInBloc()),
        ChangeNotifierProvider<SignUpBloc>(create: (_) => SignUpBloc()),
        ChangeNotifierProvider<HomeBloc>(create: (_) => HomeBloc()),
        ChangeNotifierProvider<StartUpBloc>(create: (_) => StartUpBloc()),
        ChangeNotifierProvider<AddPostBloc>(create: (_) => AddPostBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => AppDialog(child: child),
        ),
      ),
      // home: LogInScreen(),
      initialRoute: Routes.startup,
      onGenerateRoute: Router.generateRoute,
      navigatorKey: locator<NavigationService>().navigationKey,
    );
  }
}
