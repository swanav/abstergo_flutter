import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:abstergo_flutter/redux/actions.dart';
import 'package:abstergo_flutter/models/app_state.dart';
import 'package:abstergo_flutter/models/session.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
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
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
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
                child: StoreConnector<AppState, _ViewModel>(
              converter: _ViewModel.fromStore,
              builder: (context, vm) {
                return FlatButton(
                  onPressed: () {
                    vm.dispatcher(
                      _usernameController.text,
                      _passwordController.text,
                    );
                  },
                  child: Text('Submit'),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final dynamic dispatcher;
  final dynamic listener;

  _ViewModel({this.dispatcher, this.listener});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      dispatcher: (String username, String password) {
        store.dispatch(
          LoginAction(
            Session(
              username: username,
              password: password,
            ),
          ),
        );
      },
    );
  }
}
