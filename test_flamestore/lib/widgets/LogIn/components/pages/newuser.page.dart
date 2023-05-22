import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:test_flamestore/utils/NgrokLink.dart';

import 'package:test_flamestore/widgets/LogIn/components/widget/ButtonName.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/ButtonSurname.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/buttonNewUser.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/newName.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/password.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/singup.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/textNew.dart';
import 'package:test_flamestore/widgets/LogIn/components/widget/userOld.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  Future<List> senddata(
      {required String name,
      required String surname,
      required String username,
      required String password}) async {
    String uri = NgrokLink.link + "/theFlameStore/insertNewClient.php";
    final response = await http.post(
        Uri.parse(uri),
        body: {
          "name": name,
          "surname": surname,
          "username": username,
          "password": password,
          "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        });

    var datauser = json.decode(response.body);
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    var name = new ButtonName();
    var userName = new NewName();
    var surname = new ButtonSurname();
    var password = new PasswordInput();
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
                Row(
                  children: <Widget>[
                    SingUp(),
                    TextNew(),
                  ],
                ),
                name,
                surname,
                userName,
                password,
                ButtonNewUser(callback: () {
                  senddata(
                    name: name.nameController.text,
                    password: password.passwordController.text,
                    surname: surname.surnameController.text,
                    username: userName.userNameController.text,
                  );
                  Navigator.of(context).pop();
                }),
                Container(
                  child: UserOld(),
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
