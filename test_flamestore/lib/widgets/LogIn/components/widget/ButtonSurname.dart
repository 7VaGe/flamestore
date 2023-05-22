import 'package:flutter/material.dart';

class ButtonSurname extends StatefulWidget {
  TextEditingController surnameController = new TextEditingController();

  @override
  _ButtonSurnameState createState() => _ButtonSurnameState();
}

class _ButtonSurnameState extends State<ButtonSurname> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          controller: widget.surnameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Surname',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
