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
                return _PostTile(
                  title: post.title,
                  description: post.description,
                  author: post.userName,
                  onEdit: () {
                    bloc.editPost(postId: post.postId);
                  },
                  onDelete: () {
                    bloc.deletePost(postId: post.postId);
                  },
                );
              },
            ).toList();
            return ListView(
              children: children,
            );
          }
          return Center(
            child: Text('No Post have been aded yet!'),
          );
        },
      ),
    );
  }
}

class _PostTile extends StatelessWidget {
  final String title;
  final String description;
  final String author;
  final Function onEdit;
  final Function onDelete;

  const _PostTile({
    Key key,
    this.title,
    this.description,
    this.author,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        // margin: EdgeInsets.only(bottom: 30.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: $title'),
                SizedBox(height: 20.0),
                Text('Description:\n$description'),
                SizedBox(height: 30.0),
                Text('Author:\n${author}'),
              ],
            ),
            Spacer(),
            Column(
              children: [
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
                SizedBox(height: 20.0),
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.edit),
                  onPressed: onEdit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
