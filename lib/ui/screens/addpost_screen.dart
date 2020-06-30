import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text_field.dart';

import '../../blocs/addpost_bloc.dart';
import '../../models/post.dart';

class AddPostScreen extends StatelessWidget {
  final Post postToEdit;

  const AddPostScreen({Key key, this.postToEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AddPostBloc>(context);
    bloc.setUpEdit(postToEdit);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bloc.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: bloc.formKey,
          child: Column(
            children: [
              CustomFormTextField(
                hintText: 'Title',
                icon: Icons.title,
                onSaved: bloc.setTitle,
                initialValue: bloc.editingPost ? postToEdit.title : '',
              ),
              CustomFormTextField(
                hintText: 'Descrition',
                icon: Icons.description,
                maxLines: 5,
                onSaved: bloc.setDescription,
                initialValue: bloc.editingPost ? postToEdit.description : '',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.createPost();
        },
        child: !bloc.isBusy ? Icon(Icons.add) : CircularProgressIndicator(),
      ),
    );
  }
}
