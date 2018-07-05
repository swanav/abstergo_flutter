import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/models/credentials.dart';
import 'package:abstergo_flutter/models/webkiosk_exception.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _attemptLogin() {
    Credentials credentials = Credentials(
      _usernameController.text,
      _passwordController.text,
    );
    print("Attempting login for ${credentials.rollNumber}");
    _webkioskLogin(credentials)
        .then(_firebaseLogin)
        .then(_saveCredentials)
        .catchError(_webkioskExceptionHandler, test: (ex) => ex is WebkioskException);
  }

  Future<Credentials> _webkioskLogin(Credentials credentials) {
    WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
    return webkiosk.login().then((bool isLoggedIn) {
      if (!isLoggedIn) {
        print("Login Failed");
        throw WebkioskException(
            "Webkiosk authentication failed. Incorrect credentials or the server may not be responding.");
      }
      credentials.isWebkioskAuthenticated = isLoggedIn;
      return credentials;
    }).catchError((ex) {
      throw ex;
    });
  }

  void _webkioskExceptionHandler(ex) {
    Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
                (ex as WebkioskException).message.split(". ").join(".\n"),
                textAlign: TextAlign.center),
            duration: Duration(seconds: 5),
          ),
        );
  }

  Future<Credentials> _firebaseLogin(Credentials credentials) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: credentials.firebaseEmail,
      password: credentials.firebasePassword,
    )
        .catchError((error) {
      return FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: credentials.firebaseEmail,
        password: credentials.firebasePassword,
      );
    }).then((FirebaseUser user) async {
      credentials.uid = user.uid;
      return credentials;
    });
  }

  Future<bool> _saveCredentials(Credentials credentials) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("rollNumber", credentials.rollNumber);
    preferences.setString("password", credentials.password);
    preferences.setString("fb-username", credentials.firebaseEmail);
    preferences.setString("fb-password", credentials.firebasePassword);
    preferences.setString("uid", credentials.firebaseId);
    return await preferences.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Roll Number",
                ),
                keyboardType: TextInputType.numberWithOptions(),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                },
              ),
            ),
            Center(
                child: RaisedButton(
              onPressed: _attemptLogin,
              color: Colors.deepPurple,
              child: Text('Submit'),
            )),
          ],
        ),
      ),
    );
  }
}
