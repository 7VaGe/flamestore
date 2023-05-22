import 'package:flutter/material.dart';

import 'widgets/LogIn/LogInWidget.dart';
import 'widgets/LoggedIn/LoggedInWidget.dart';

main(List<String> args) {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp(MyApp());
}

class MyLogIn extends StatefulWidget {
  @override
  _MyLogInState createState() => _MyLogInState();
}

class _MyLogInState extends State<MyLogIn> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'logInScreen',
      routes: {
        'loggedInScreen': (context) => LoggedInWidget(),
        'logInScreen': (context) => LogInWidget(),
      },
    );
  }
}
