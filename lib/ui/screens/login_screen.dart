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
            print('yes');

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
