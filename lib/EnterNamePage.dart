import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcq_ms/questions/QuestionsData.dart';
import 'package:mcq_ms/questions/view/QuestionsPage.dart';
import 'package:mcq_ms/user/UserModel.dart';

class EnterNamePage extends StatefulWidget {
  @override
  _EnterNamePageState createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  String _userName;

  var _formKey = GlobalKey<FormState>();

  get isValidName {
    return _formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter your name"),
      ),
      body: mainView(),
      floatingActionButton: nextButton(),
    );
  }

  Widget mainView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          enterNameText(),
          enterNameTextField(),
        ],
      ),
    );
  }

  Text enterNameText() {
    return Text(
      "Please Enter your name",
      style: TextStyle(fontSize: 30),
    );
  }

  Padding enterNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Form(
        key: _formKey,
        child: TextFormField(
          validator: (value) => nameValidator(value),
          decoration: InputDecoration(hintText: "eg: Ahmed"),
          keyboardType: TextInputType.text,
          onChanged: (value) => _userName = value,
        ),
      ),
    );
  }

  nextButton() {
    return FloatingActionButton(
      child: Icon(
        Icons.navigate_next,
        size: 40,
      ),
      onPressed: () {
        onNextPressed();
      },
    );
  }

  void onNextPressed() {
    if (isValidName) {
      saveUserData();
      navigateToQuestionPage();
    }
  }

  navigateToQuestionPage() {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (BuildContext context) => QuestionsPage(0)));
  }

  randomizeQuestions() {}

  nameValidator(value) {
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  void saveUserData() {
    UserModel.instance.userName = _userName;
    UserModel.instance.userScore = 0;
    var questions = QuestionsData.questions;
    questions.shuffle();
    UserModel.instance.questions = questions;
  }
}
