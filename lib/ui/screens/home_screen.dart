import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../blocs/home_bloc.dart';

import '../../models/post.dart';

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
          IconButton(
            color: Colors.black,
            onPressed: () {
              bloc.navigateToStories();
            },
            icon: Icon(
              Icons.book,
              color: Colors.black,
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

          if (snapshot.connectionState == ConnectionState.active && snapshot.data.isNotEmpty) {
            children = snapshot.data.map(
              (post) {
                return _PostTile(
                  post: post,
                  onEdit: () {
                    bloc.editPost(postId: post.postId);
                  },
                  onDelete: () {
                    bloc.deletePost(
                      postId: post.postId,
                      imageFileName: post.imageFileName,
                    );
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
  final Post post;
  final Function onEdit;
  final Function onDelete;

  const _PostTile({
    Key key,
    this.post,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Container(
        //if htere is an image we dont wan to give a fixed height
        height: post.imageUrl != null ? null : 150,
        padding: EdgeInsets.all(20.0),
        // margin: EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: [
            post.imageUrl != null
                ? SizedBox(
                    height: 250,
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: post.imageUrl,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                : SizedBox(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: ${post.title}'),
                    SizedBox(height: 10.0),
                    Text('Description:\n${post.description}'),
                    SizedBox(height: 10.0),
                    Text('Author:\n${post.userName}'),
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
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.edit),
                      onPressed: onEdit,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
