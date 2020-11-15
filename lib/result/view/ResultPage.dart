import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcq_ms/EnterNamePage.dart';
import 'package:mcq_ms/user/UserModel.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: mainView(),
    );
  }

  Widget mainView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Name : " + UserModel.instance.userName,
                style: TextStyle(fontSize: 30)),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Score : " + UserModel.instance.userScore.toString(),
                style: TextStyle(fontSize: 40)),
          ),
          RaisedButton(
            onPressed: () {
              onPlayAgainPressed();
            },
            child: Text(
              "Play Again ?",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.blueAccent,
          )
        ],
      ),
    );
  }

  void onPlayAgainPressed() {
    clearUserData();
    navigateToEnterName();
  }

  void navigateToEnterName() {
    Navigator.of(context).push(
        CupertinoPageRoute(builder: (BuildContext context) => EnterNamePage()));
  }

  void clearUserData() {
    UserModel.instance.userName = null;
    UserModel.instance.userScore = 0;
  }
}
