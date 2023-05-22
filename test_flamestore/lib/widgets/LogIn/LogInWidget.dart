import 'package:flutter/material.dart';

import 'components/pages/login.page.dart';

class LogInWidget extends StatefulWidget {
  @override
  _LogInWidgetState createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
