import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:karbarab/config/game_mode.dart';
import 'package:karbarab/widgets/button.dart';
import 'package:karbarab/widgets/card_answer.dart';
import 'package:karbarab/widgets/card_game.dart';
import 'package:karbarab/widgets/card_plain.dart';
import 'package:karbarab/widgets/typography.dart';

class GameStartScreen extends StatelessWidget {
  static const String routeName = '/start';
  final GameMode mode;
  GameStartScreen({@required this.mode});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CardQuiz(mode: mode),
          ],
        ),
      ),
    );
  }
}

class CardQuiz extends StatefulWidget {
  final GameMode mode;
  CardQuiz({@required this.mode});

  @override
  _CardQuizState createState() => _CardQuizState();
}

class _CardQuizState extends State<CardQuiz> {
  String _currentAnswer = '';
  String _rightAnswer = 'A';
  double _currentPoint = 300;
  bool _correntAnswer = false;

  _selectAnswer(answer) {
    setState(() {
      _currentAnswer = answer;
    });
  }

  _applyAnswer() {
    if (_rightAnswer == _currentAnswer) {
      setState(() {
        _correntAnswer = true;
      });
    } else {
      setState(() {
        _currentPoint = _currentPoint - 100;
        _correntAnswer = false;
      });
    }
  }
  

  Widget build(BuildContext context) {
    // print(_correntAnswer);
    return Column(
      children: [
        Stack(
          children: [
            CardPlain(),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: BiggerText(
                    text: 'Jawab soal ini dengan benar', dark: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 80.0,
                bottom: 20.0,
                left: 30,
                right: 30,
              ),
              // child: CardGame(rotation: _rotationFactor),
              child: CardGame(point: _currentPoint, correct: _correntAnswer),
            )
          ],
        ),
        Column(
          children: [
            CardAnswer(
              answer: 'بطاقة',
              answerId: 'A',
              answerMode: CardAnswerMode.Arab,
              currentAnswer: _currentAnswer == 'A',
              selectAnswer: _selectAnswer,
            ),
            CardAnswer(
              answer: 'كتاب',
              answerId: 'B',
              answerMode: CardAnswerMode.Arab,
              currentAnswer: _currentAnswer == 'B',
              selectAnswer: _selectAnswer,
            ),
            CardAnswer(
              answer: 'التلفزيون',
              answerId: 'C',
              answerMode: CardAnswerMode.Arab,
              currentAnswer: _currentAnswer == 'C',
              selectAnswer: _selectAnswer,
            ),
            CardAnswer(
              answer: 'زهرة',
              answerId: 'D',
              answerMode: CardAnswerMode.Arab,
              currentAnswer: _currentAnswer == 'D',
              selectAnswer: _selectAnswer,
            ),
            Container(height: 20.0),
            Button(
              onTap: _applyAnswer,
              text: 'Yakin',
            ),
          ],
        ),
      ],
    );
  }
}
