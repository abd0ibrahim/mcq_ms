import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mcq_ms/result/view/ResultPage.dart';
import 'package:mcq_ms/user/UserModel.dart';

import '../QuestionsData.dart';

class QuestionsPage extends StatefulWidget {
  var questionIndex;
  QuestionsPage(this.questionIndex);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  var _question;
  var _answers;
  var _correctAnswer;

  getQuestionTitle() {
    return "Q" + widget.questionIndex.toString() + " : " + _question['title'];
  }

  @override
  Widget build(BuildContext context) {
    _question = UserModel.instance.questions[widget.questionIndex];
    _question['answers'].shuffle();
    _answers = _question['answers'];
    _correctAnswer = _question['correctAnswer'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Question #" + widget.questionIndex.toString() ?? ""),
      ),
      body: mainView(),
    );
  }

  mainView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            nameAndScoreSection(),
            questionTitle(),
            questionsSection()
          ],
        ),
      ),
    );
  }

  Text questionTitle() {
    return Text(
      getQuestionTitle(),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Column nameAndScoreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name : " + UserModel.instance.userName ?? "",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(height: 20),
        Text(
          "Score : " + UserModel.instance.userScore.toString() ?? "",
          style: TextStyle(
              fontSize: 30, color: Colors.green, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 50),
      ],
    );
  }

  questionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: _answers.length ?? 0,
              itemBuilder: (context, answerindex) {
                return RaisedButton(
                  color: Colors.blue,
                  onPressed: () => onAnswerPressed(answerindex),
                  child: Text(
                    _answers[answerindex]['text'].toString(),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              }),
        ],
      ),
    );
  }

  onAnswerPressed(answerIndex) {
    if (isCorrectAnswer(answerIndex)) {
      UserModel.instance.userScore += 5;
      showToast("Correct Answer +5 !!", Colors.green);
    } else {
      showToast("Wrong Answer", Colors.red);
    }

    navigateToNextPage();
  }

  navigateToNextPage() {
    if (isLastQuestion()) {
      navigateTo(ResultPage());
    } else {
      navigateTo(QuestionsPage(widget.questionIndex + 1));
    }
  }

  bool isLastQuestion() =>
      widget.questionIndex == UserModel.instance.questions.length - 1;

  navigateTo(Widget page) {
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => page));
  }

  bool isCorrectAnswer(answerIndex) {
    return _answers[answerIndex]['text'].toString().toLowerCase() ==
        _correctAnswer.toString().toLowerCase();
  }

  showToast(text, color) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
