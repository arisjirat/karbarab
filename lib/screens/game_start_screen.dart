import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:karbarab/config/game_mode.dart';
import 'package:karbarab/helper/model_quiz.dart';
import 'package:karbarab/request/quiz.dart';
import 'package:karbarab/widgets/button.dart';
import 'package:karbarab/widgets/card_answer.dart';
import 'package:karbarab/widgets/card_quiz.dart';
import 'package:karbarab/widgets/congratulation.dart';

class GameStartScreen extends StatefulWidget {
  static const String routeName = '/start';
  final GameMode mode;
  GameStartScreen({@required this.mode});

  @override
  _GameStartScreenState createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  List _listQuiz = <QuizModel>[];
  List _recentAnswers = [];
  bool _isCorrect = false;
  bool _loading = false;

  String _currentAnswer = '';
  String _rightAnswer = '';
  double _currentPoint = 300;
  QuizModel _currentQuiz;

  bool _inCorrectAnswer(key) {
    return _recentAnswers.contains(key);
  }

  @override
  void initState() {
    super.initState();
    _getQuiz();
  }

  void _getQuiz() {
    setState(() {
      _currentPoint = 300;
      _loading = true;
      _isCorrect = false;
      _currentAnswer = '';
      _recentAnswers = [];
    });

    Timer(Duration(seconds: 1), () {
      var listQuiz = getQuizData();
      listQuiz.shuffle();
      listQuiz = listQuiz.sublist(0, 4);
      final random = 0 + new Random().nextInt(listQuiz.length - 0);
      setState(() {
        _loading = false;
        _listQuiz = listQuiz.sublist(0, 4);
        _currentQuiz = _listQuiz[random];
        _rightAnswer = _getAnswerIndex(random);
      });

      // print(_listQuiz.length);
    });
  }

  String _getAnswerIndex(index) {
    const answer = ['A', 'B', 'C', 'D'];
    return answer[index];
  }

  void _selectAnswer(answer) {
    setState(() {
      _currentAnswer = answer;
    });
  }

  void _applyAnswer() {
    if (_currentAnswer == '') return;
    if (_rightAnswer == _currentAnswer) {
      setState(() {
        _isCorrect = true;
      });
    } else {
      setState(() {
        _recentAnswers.add(_currentAnswer);
        _currentPoint = _currentPoint - 100;
        _currentAnswer = '';
      });
    }
  }

  List<Widget> buildWidgets(List<QuizModel> list) {
    return list
      .asMap()
      .map((i, w) => MapEntry(
          i,
          CardAnswer(
            loading: _loading,
            answer: w.arab,
            answerId: _getAnswerIndex(i),
            answerMode: CardAnswerMode.Arab,
            currentAnswer: _currentAnswer == _getAnswerIndex(i),
            selectAnswer: _selectAnswer,
            disabled: _inCorrectAnswer(_getAnswerIndex(i)),
          )))
      .values
      .toList();
  }

  Widget buildQuiz(_deviceHeight) {
    return Container(
      height: 0.6 * _deviceHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: buildWidgets(_listQuiz),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20.0,
            ),
            child: Button(
              onTap: _applyAnswer,
              text: 'Yakin',
              disabled: _currentAnswer == '',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    final double _deviceHeight = MediaQuery.of(context).size.height - padding;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardQuiz(
              currentPoint: _currentPoint,
              isCorrect: _isCorrect,
              loading: _loading,
              deviceHeight: _deviceHeight,
              quiz: _currentQuiz,
              mode: widget.mode,
            ),
            _isCorrect
              ? Congratulation(
                  isCorrect: _isCorrect,
                  onNewGame: _getQuiz,
                  point: _currentPoint.round(),
                )
              : buildQuiz(_deviceHeight)
          ],
        ),
      ),
    );
  }
}
