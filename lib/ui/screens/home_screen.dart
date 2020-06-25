import 'package:bloc_app_template/models/post.dart';
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
        actions: [
          IconButton(
            color: Colors.red,
            onPressed: () {
              bloc.signOut();
            },
            icon: Icon(
              Icons.lock_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          bloc.navigateToAddPost();
        },
      ),
      body: StreamBuilder<List<Post>>(
        stream: bloc.postsStream,
        builder: (_, snapshot) {
          List<Widget> children;
          if (snapshot.connectionState == ConnectionState.active) {
            children = snapshot.data.map(
              (post) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(post.title),
                  color: Colors.red,
                );
              },
            ).toList();
            return Column(
              children: children,
            );
          }
          return Container();
        },
      ),
    );
  }
}
