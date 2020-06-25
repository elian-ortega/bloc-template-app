import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/login_bloc.dart';

import '../widgets/custom_text_field.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LogInBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: bloc.formKey,
              child: Column(
                children: [
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
            !bloc.isBusy ? _Buttons() : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LogInBloc>(context);
    return Column(
      children: [
        RaisedButton(
          onPressed: () {
            bloc.logInWithEmail();
          },
          color: Colors.blue,
          child: Text('Log In'),
        ),
        FlatButton(
          onPressed: () {
            bloc.navigateToSignUp();
          },
          child: Text('Don\'t have an account? Go to Sing Up!'),
        )
      ],
    );
  }
}
