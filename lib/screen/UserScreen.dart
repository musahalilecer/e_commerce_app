import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => UserScreenState();
}
class UserScreenState extends State<UserScreen>{
  List<User> user = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Account"),
      ),
      body: Card(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}