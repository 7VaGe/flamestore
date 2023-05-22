import 'package:flutter/material.dart';

class NewName extends StatefulWidget {
  TextEditingController userNameController = TextEditingController();
  @override
  _NewNomeState createState() => _NewNomeState();
}

class _NewNomeState extends State<NewName> {
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
          controller: widget.userNameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Username',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
