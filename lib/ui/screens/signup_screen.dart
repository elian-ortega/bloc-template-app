import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/signup_bloc.dart';

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
                  CustomTextField(
                    hintText: 'Name',
                    icon: Icons.person,
                    onChanged: bloc.setName,
                  ),
                  CustomTextField(
                    hintText: 'Email',
                    icon: Icons.mail,
                    onChanged: bloc.setEmail,
                  ),
                  CustomTextField(
                    hintText: 'Password',
                    icon: Icons.security,
                    onChanged: bloc.setPassword,
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
