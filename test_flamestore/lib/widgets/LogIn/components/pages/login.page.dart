import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_flamestore/utils/CurrentUser.dart';
import 'package:test_flamestore/utils/NgrokLink.dart';

import 'package:test_flamestore/widgets/LogIn/components/widget/button.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/first.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/inputEmail.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/password.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/textLogin.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/verticalText.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var passwordInput = PasswordInput();
  var emailInput = InputEmail();

  Future<bool> _logInUser(String username, String password) async {
    String uri = NgrokLink.link + "/theFlameStore/logIn.php";
    final response = await http.post(
      Uri.parse(uri),
      body: {
        "username": username,
        "password": password,
      },
    );

    CurrentUser.userId = response.body;

    return response.body != "false" ? true : false;
  }

  void _switchToLogInScreen(String currentUser) {
    CurrentUser.userLoggedIn = currentUser;
    Navigator.of(context).pushNamed('loggedInScreen');
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Error while logging in!"),
      content: Text("Wrong email or password inserted."),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
    String uri = NgrokLink.link + '/theFlameStore/insertimages.php';
    http.post(Uri.parse(uri));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                emailInput,
                passwordInput,
                ButtonLogin(
                  callback: () => _logInUser(emailInput.emailController.text,
                          passwordInput.passwordController.text)
                      .then(
                    (value) => value
                        ? _switchToLogInScreen(emailInput.emailController.text)
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          ),
                  ),
                ),
                FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
