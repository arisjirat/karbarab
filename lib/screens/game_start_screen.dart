import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/config/game_mode.dart';
import 'package:karbarab/helper/scale_calculator.dart';
import 'package:karbarab/widgets/button.dart';
import 'package:karbarab/widgets/card_answer.dart';
import 'package:karbarab/widgets/card_game.dart';
import 'package:karbarab/widgets/card_plain.dart';
import 'package:karbarab/widgets/congrats.dart';
import 'package:karbarab/widgets/typography.dart';

class GameStartScreen extends StatefulWidget {
  static const String routeName = '/start';
  final GameMode mode;
  GameStartScreen({@required this.mode});

  @override
  _GameStartScreenState createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  bool _isCorrect = false;

  String _currentAnswer = '';
  String _rightAnswer = 'A';
  double _currentPoint = 300;
  List _recentAnswers = [];

  _selectAnswer(answer) {
    setState(() {
      _currentAnswer = answer;
    });
  }

  bool _inCorrectAnswer(key) {
    return _recentAnswers.contains(key);
  }

  _applyAnswer() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardQuiz(
              currentPoint: _currentPoint,
              isCorrect: _isCorrect,
            ),
            _isCorrect
                ? Congratulation(
                    isCorrect: _isCorrect,
                  )
                : Column(
                    children: [
                      CardAnswer(
                        answer: 'بطاقة',
                        answerId: 'A',
                        answerMode: CardAnswerMode.Arab,
                        currentAnswer: _currentAnswer == 'A',
                        selectAnswer: _selectAnswer,
                        disabled: _inCorrectAnswer('A'),
                      ),
                      CardAnswer(
                        answer: 'كتاب',
                        answerId: 'B',
                        answerMode: CardAnswerMode.Arab,
                        currentAnswer: _currentAnswer == 'B',
                        selectAnswer: _selectAnswer,
                        disabled: _inCorrectAnswer('B'),
                      ),
                      CardAnswer(
                        answer: 'التلفزيون',
                        answerId: 'C',
                        answerMode: CardAnswerMode.Arab,
                        currentAnswer: _currentAnswer == 'C',
                        selectAnswer: _selectAnswer,
                        disabled: _inCorrectAnswer('C'),
                      ),
                      CardAnswer(
                        answer: 'زهرة',
                        answerId: 'D',
                        answerMode: CardAnswerMode.Arab,
                        currentAnswer: _currentAnswer == 'D',
                        selectAnswer: _selectAnswer,
                        disabled: _inCorrectAnswer('D'),
                      ),
                      Container(height: scaleCalculator(20.0, context)),
                      Button(
                        onTap: _applyAnswer,
                        text: 'Yakin',
                        disabled: _currentAnswer == '',
                      ),
                      Container(height: scaleCalculator(20.0, context)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class Congratulation extends StatelessWidget {
  final bool isCorrect;
  const Congratulation({this.isCorrect});
  void _nextCard() {
    print('next card');
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      height: 0.5 * _deviceHeight,
      child: Column(
        children: [
          Image(image: AssetImage('congrat-character.png'), height: 200),
          Congrats(play: isCorrect),
          Container(height: scaleCalculator(20.0, context)),
          BoldRegularText(
            text: 'Kamu dapat 300 points!',
            dark: true,
          ),
          Container(height: scaleCalculator(20.0, context)),
          Button(
            onTap: _nextCard,
            text: 'Kata Selanjutnya',
          ),
        ],
      ),
    );
  }
}

class CardQuiz extends StatelessWidget {
  final bool isCorrect;
  final double currentPoint;

  CardQuiz({@required this.currentPoint, @required this.isCorrect});

  Widget build(BuildContext context) {
    final double _deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double _cardPlainHeight = 0.25 * _deviceHeight;
    final double _cardGameHeight = 0.3 * _deviceHeight;
    return Column(
      children: [
        Stack(
          children: [
            CardPlain(
              height: _cardPlainHeight,
              color: isCorrect ? greenColor : greyColor,
              secondaryColor: isCorrect ? greenColorLight : softGreyColor,
            ),
            CardGame(
              point: currentPoint,
              correct: isCorrect,
              height: _cardGameHeight,
            ),
          ],
        ),
      ],
    );
  }
}
