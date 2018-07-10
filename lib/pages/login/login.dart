import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/models/credentials.dart';
import 'package:abstergo_flutter/models/webkiosk_exception.dart';
import 'package:abstergo_flutter/pages/layout/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0x92, 0x69, 0x8D, 1.0),
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(fontFamily: 'ProductSans'),
        ),
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

  bool loading = false;

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
    setState(() {
      loading = true;
    });
    _webkioskLogin(credentials)
        .then(_firebaseLogin)
        .then(_saveCredentials)
        .catchError(_webkioskExceptionHandler,
            test: (ex) => ex is WebkioskException)
        .whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  Future<Credentials> _webkioskLogin(Credentials credentials) async {
    WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
    try {
      if (!await webkiosk.login()) {
        print("Login Failed");
        throw WebkioskException(
            "Webkiosk authentication failed. Incorrect credentials or the server may not be responding.");
      }
    } on WebkioskException catch (ex) {
      throw (ex);
    } catch (ex) {
      print(ex);
    }
    return credentials;
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

  Future<Credentials> _firebaseLogin(Credentials credentials) async {
    FirebaseUser user;
    try {
      user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: credentials.firebaseEmail,
        password: credentials.firebasePassword,
      );
    } on PlatformException catch (ex) {
      print(ex.message ==
          "The password is invalid or the user does not have a password.");
      print("Sign in failed. Creating new user.");
      user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: credentials.firebaseEmail,
        password: credentials.firebasePassword,
      );
    }

    credentials.uid = user.uid;
    return credentials;
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
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/background.png'),
        ),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (loading == true) {
            return Loading(
              color: Colors.white,
            );
          }

          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.white30,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  child: TextFormField(
                    autofocus: true,
                    controller: _usernameController,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Comfortaa',
                    ),
                    decoration: InputDecoration(
                      labelText: "Roll Number",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Comfortaa',
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
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
                  color: Colors.white30,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Comfortaa',
                    ),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Comfortaa',
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your password';
                      }
                    },
                  ),
                ),
                Container(
                  color: Colors.white30,
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Center(
                    child: FlatButton(
                      color: Colors.white70,
                      onPressed: _attemptLogin,
                      child: Text(
                        'Submit',
                        style: TextStyle(fontFamily: 'Comfortaa'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
