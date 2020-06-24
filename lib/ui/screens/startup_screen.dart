import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/startup_bloc.dart';

class StartUpScreen extends StatefulWidget {
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<StartUpBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            bloc.setUp();
          },
          child: Text('Start App'),
        ),
      ),
    );
  }
}
