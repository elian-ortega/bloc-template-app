import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/stories_bloc.dart';

class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<StoriesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.listenToStories(),
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
