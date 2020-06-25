import 'package:bloc_app_template/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/addpost_bloc.dart';

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AddPostBloc>(context);
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
              ),
              CustomFormTextField(
                hintText: 'Descrition',
                icon: Icons.description,
                maxLines: 5,
                onSaved: bloc.setDescription,
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
