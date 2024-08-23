import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserScreenLogout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserScreenLogoutState();
}

class UserScreenLogoutState extends State<UserScreenLogout> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Account"),
      ),
      body: Card(
        shape: Border.all(color: Colors.amber),
        margin: EdgeInsets.only(top: 150.0, bottom: 150.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Enter name"),
            ),
            TextField(
              controller: mail,
              decoration: InputDecoration(labelText: "Enter the mail"),
            ),
            Padding(padding: EdgeInsets.only(top: 40.0)),
            ElevatedButton(
              style: ButtonStyle(

              ),
                onPressed: () {

                },
                child: Text("Log out")
            ),
            Row(
              children: [
                ButtonBar(
                  children: [
                    ElevatedButton(
                        onPressed: () {

                        },
                        child: const Row(
                          children: [
                            Text("Log Out Google"),
                            Icon(Icons.android)
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () {

                        }, child: const Row(
                            children: [
                              Text("Log Out Facebook"),
                              Icon(Icons.facebook)
                            ],
                      )
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
