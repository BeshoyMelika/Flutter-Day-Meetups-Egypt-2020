import 'package:flutter/material.dart';
import 'package:flutterday/screens/auth_screen.dart';
import 'package:flutterday/services/auth.dart';
import 'package:flutterday/widgets/original_button.dart';

class AuthForm extends StatefulWidget {
  final AuthType authType;

  const AuthForm({Key key, @required this.authType}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';
  AuthBase authBase = AuthBase();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            TextFormField(
              onChanged: (value) => _email = value,
              validator: (value) =>
                  value.isEmpty ? 'Enter a valid email' : null,
              decoration: InputDecoration(
                  labelText: 'Enter your email',
                  hintText: 'ex: test@gmail.com'),
            ),
            SizedBox(height: 12),
            TextFormField(
              onChanged: (value) => _password = value,
              validator: (value) => value.length < 6
                  ? 'Your password must be larger than 6 characters'
                  : null,
              decoration: InputDecoration(
                labelText: 'Enter your password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            OriginalButton(
              text: widget.authType == AuthType.login ? 'Login' : 'Register',
              textColor: Colors.white,
              bgColor: Colors.lightBlue,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  if (widget.authType == AuthType.login) {
                    await authBase.loginWithEmailAndPassword(_email, _password);
                    Navigator.of(context).pushReplacementNamed('home');
                  }
                  else {
                    await authBase.registerWithEmailAndPassword(
                        _email, _password);
                    Navigator.of(context).pushReplacementNamed('home');
                  }
                }
              },
            ),
            SizedBox(height: 5),
            FlatButton(
              onPressed: () {
                if (widget.authType == AuthType.login)
                  Navigator.of(context).pushReplacementNamed('register');
                else
                  Navigator.of(context).pushReplacementNamed('login');
              },
              child: Text(
                widget.authType == AuthType.login
                    ? 'Don\'t have an account?'
                    : 'You have an account?',
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
