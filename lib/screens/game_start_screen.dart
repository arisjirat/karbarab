import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/config/game_mode.dart';
import 'package:karbarab/helper/model_quiz.dart';
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
  List _listQuiz = <QuizModel>[];
  bool _isCorrect = false;
  bool _loading = false;

  String _currentAnswer = '';
  String _rightAnswer = '';
  double _currentPoint = 300;
  List _recentAnswers = [];
  QuizModel _currentQuiz;

  bool _inCorrectAnswer(key) {
    return _recentAnswers.contains(key);
  }

  // @override
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
      var listQuiz = <QuizModel>[];
      listQuiz.add(
        QuizModel(
          arab: 'طاولة',
          arabVoice: 'Arab Voice',
          bahasa: 'Meja',
          date: DateTime.now(),
          id: '1',
          image: 'https://pngimg.com/uploads/table/table_PNG7005.png',
        ),
      );
      listQuiz.add(
        QuizModel(
          arab: 'الكرسي',
          arabVoice: 'Arab Voice',
          bahasa: 'Bangku',
          date: DateTime.now(),
          id: '2',
          image: 'https://pngimg.com/uploads/chair/chair_PNG6862.png',
        ),
      );
      listQuiz.add(
        QuizModel(
          arab: 'الباب',
          arabVoice: 'Voice 3',
          bahasa: 'Pintu',
          date: DateTime.now(),
          id: '3',
          image:
              'https://img.favpng.com/22/1/21/door-download-png-favpng-rgjhMmpYzLEFQXefNmWurpGUg.jpg',
        ),
      );
      listQuiz.add(
        QuizModel(
          arab: 'خزانة',
          arabVoice: 'Voice 4',
          bahasa: 'Lemari',
          date: DateTime.now(),
          id: '4',
          image:
              'https://p7.hiclipart.com/preview/379/769/121/cupboard-cabinetry-clip-art-cupboard-png-thumbnail.jpg',
        ),
      );
      listQuiz.add(
        QuizModel(
          arab: 'زهرة',
          arabVoice: 'Voice 2',
          bahasa: 'Bunga',
          date: DateTime.now(),
          id: '5',
          image:
              'https://pluspng.com/img-png/flower-png-dahlia-flower-png-transparent-image-1644.png',
        ),
      );
      listQuiz.add(
        QuizModel(
          arab: 'منزل',
          arabVoice: 'Voice 2',
          bahasa: 'Rumah',
          date: DateTime.now(),
          id: '6',
          image:
              'https://www.freeiconspng.com/uploads/description-crystal-project-folder-home-8.png',
        ),
      );
      listQuiz.add(
        QuizModel(
          arab: 'الشجرة',
          arabVoice: 'Voice 2',
          bahasa: 'Pohon',
          date: DateTime.now(),
          id: '7',
          image:
              'https://www.freepnglogos.com/uploads/tree-plan-png/tree-plan-tree-png-image-purepng-transparent-png-image-12.png',
        ),
      );
      listQuiz.add(
        QuizModel(
          arab: 'الكتاب',
          arabVoice: 'Voice 2',
          bahasa: 'Buku',
          date: DateTime.now(),
          id: '8',
          image:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Gambar_Buku.png/464px-Gambar_Buku.png',
        ),
      );
      listQuiz.add(
        QuizModel(
          arab: 'قلم',
          arabVoice: 'Voice 2',
          bahasa: 'Pulpen',
          date: DateTime.now(),
          id: '9',
          image: 'https://pngimg.com/uploads/pen/pen_PNG7415.png',
        ),
      );
      listQuiz.shuffle();
      listQuiz = listQuiz.sublist(0, 4);
      final random = 0 + new Random().nextInt(listQuiz.length - 0);
      setState(() {
        _loading = false;
        _listQuiz = listQuiz.sublist(0, 4);
        _currentQuiz = _listQuiz[random];
        _rightAnswer = _getAnswerIndex(random);
      });

      print(_listQuiz.length);
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

  List<Widget> _buildWidgets(List<QuizModel> list) {
    return list
      .asMap()
      .map((i, w) => MapEntry(
        i,
        CardAnswer(
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

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;
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
              // mode: _mode,
            ),
            _isCorrect
                ? Congratulation(
                    isCorrect: _isCorrect,
                    onNewGame: _getQuiz,
                    point: _currentPoint,
                  )
                : Container(
                    height: 0.6 * _deviceHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              ..._buildWidgets(_listQuiz),
                            ],
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
                  ),
          ],
        ),
      ),
    );
  }
}

class Congratulation extends StatelessWidget {
  final bool isCorrect;
  final Function onNewGame;
  final double point;
  const Congratulation({
    @required this.isCorrect,
    @required this.onNewGame,
    @required this.point,
  });
  void _nextCard() {
    onNewGame();
  }

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).padding.top - 25;
    final double _deviceHeight = MediaQuery.of(context).size.height - padding;
    return Container(
      height: 0.5 * _deviceHeight,
      child: Column(
        children: [
          Image(image: AssetImage('congrat-character.png'), height: 200),
          Congrats(play: isCorrect),
          Container(height: scaleCalculator(20.0, context)),
          BoldRegularText(
            text: 'Kamu dapat ${point.toString()} points!',
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
  final bool loading;
  final double deviceHeight;
  final QuizModel quiz;

  CardQuiz({
    @required this.currentPoint,
    @required this.isCorrect,
    @required this.loading,
    @required this.deviceHeight,
    @required this.quiz,
  });

  Widget build(BuildContext context) {
    final double _cardPlainHeight = 0.3 * deviceHeight;
    final double _cardGameHeight = 0.3 * deviceHeight;
    return Container(
      height: 0.4 * deviceHeight,
      child: Column(
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
                loading: loading,
                quiz: quiz,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
