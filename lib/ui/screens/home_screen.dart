import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.title),
      ),
    );
  }
}
