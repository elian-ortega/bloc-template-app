import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/stories_bloc.dart';

class StoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<StoriesBloc>(context);
    bloc.setUp();
    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.getStories(),
        child: !bloc.isBusy
            ? Icon(Icons.library_books)
            : CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
      ),
      body: bloc.stories.isNotEmpty
          ? ListView.builder(
              itemCount: bloc.stories.length,
              itemBuilder: (contex, index) {
                return ListTile(
                  title: Text(bloc.stories[index].storyTitle),
                  subtitle: Text(bloc.stories[index].category),
                );
              },
            )
          : Center(
              child: Text('No stories available'),
            ),
    );
  }
}
