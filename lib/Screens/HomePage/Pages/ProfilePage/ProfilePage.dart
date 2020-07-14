import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.translate,
                size: 35,
              ),
              onPressed: () {
                print("Icon Pressed");
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "An article is a word that is used with a noun to specify grammatical definiteness of the noun, and in some languages extending to volume or numerical scope. The articles in English grammar are the and a/an, and in certain contexts some",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
