import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/auth/signup_bloc.dart';

import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignUpBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.title),
      ),
      body: !bloc.isBusy
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: bloc.formKey,
                    child: Column(
                      children: [
                        CustomFormTextField(
                          hintText: 'Name',
                          icon: Icons.person,
                          onSaved: bloc.setName,
                        ),
                        CustomFormTextField(
                          hintText: 'Email',
                          icon: Icons.mail,
                          onSaved: bloc.setEmail,
                        ),
                        CustomFormTextField(
                          hintText: 'Password',
                          icon: Icons.security,
                          onSaved: bloc.setPassword,
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      bloc.createUserWithEmail();
                    },
                    color: Colors.blue,
                    child: Text('SignUp'),
                  ),
                  FlatButton(
                    onPressed: () {
                      bloc.navigateToLogIn();
                    },
                    child: Text(
                      'Already have an account? Go to LogIn!',
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
