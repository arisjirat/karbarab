import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/config/score_value.dart';
import 'package:karbarab/core/ui/popup.dart';
import 'package:karbarab/features/quiz/bloc/quiz_bloc.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:karbarab/core/ui/button.dart';
import 'package:karbarab/core/ui/cards/card_answer.dart';
import 'package:karbarab/core/ui/cards/card_quiz.dart';
import 'package:karbarab/core/ui/congratulation.dart';
import 'package:karbarab/features/score/bloc/score_bloc.dart';

String _getAnswerIndex(index) {
  const answer = ['A', 'B', 'C', 'D'];
  return answer[index];
}

const APP_ID = 'ca-app-pub-8844883376001707~8468099801';

class GameStartScreen extends StatefulWidget {
  static const String routeName = '/start';
  final GameMode mode;
  GameStartScreen({@required this.mode});

  @override
  _GameStartScreenState createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   testDevices: APP_ID != null ? <String>[APP_ID] : null,
  //   keywords: <String>['Games', 'Kartu', 'Arab'],
  // );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<QuizBloc>(context).add(GetQuiz());
  }

  @override
  Widget build(BuildContext context) {
    final QuizBloc quizBloc = BlocProvider.of<QuizBloc>(context);
    final ScoreBloc scoreBloc = BlocProvider.of<ScoreBloc>(context);
    final MediaQueryData mediaContext = MediaQuery.of(context);
    final double padding =
        mediaContext.padding.top + mediaContext.padding.bottom;
    final double _deviceHeight = mediaContext.size.height - padding;
    return Scaffold(
      body: BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
        if (state is HasQuiz) {
          return GameQuiz(
            deviceHeight: _deviceHeight,
            mode: widget.mode,
            list: state.list,
            correct: state.correct,
            quizBloc: quizBloc,
            scoreBloc: scoreBloc,
          );
        }
        return Container(
          width: 0,
          height: 0,
        );
      }),
    );
  }
}

class GameQuiz extends StatefulWidget {
  final double deviceHeight;
  final GameMode mode;
  final List<QuizModel> list;
  final QuizModel correct;
  final QuizBloc quizBloc;
  final ScoreBloc scoreBloc;

  const GameQuiz({
    @required this.deviceHeight,
    @required this.mode,
    @required this.list,
    @required this.correct,
    @required this.quizBloc,
    @required this.scoreBloc,
  });

  @override
  _GameQuizState createState() => _GameQuizState();
}

class _GameQuizState extends State<GameQuiz> {
  List<String> _recentAnswers = [];
  bool _isCorrect = false;
  bool _loading = false;
  String _currentAnswer = '';
  double _currentPoint = SCORE_BASE;

  String get _rightAnswer =>
      _getAnswerIndex(widget.list.indexOf(widget.correct));

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
      _currentPoint = SCORE_BASE;
      _loading = true;
      _isCorrect = false;
      _currentAnswer = '';
      _recentAnswers = [];
    });
    Timer(const Duration(milliseconds: 500), () {
      widget.quizBloc.add(GetQuiz());
      setState(() {
        _loading = false;
      });
    });
  }

  void _selectAnswer(answer) {
    setState(() {
      _currentAnswer = answer;
    });
  }

  void _applyAnswer() {
    if (_rightAnswer == _currentAnswer && _currentAnswer != '') {
      setState(() {
        _isCorrect = true;
      });
      widget.scoreBloc.add(AddScoreUser(
        mode: widget.mode,
        metaQuiz: widget.correct,
        score: _currentPoint.round(),
        quizId: widget.correct.id,
      ));
    } else if (_recentAnswers.length > 1) {
      popup(
        context,
        text: 'Kata Selanjutnya?',
        cancel: () {
          Navigator.of(context).pop();
        },
        confirm: () {
          _getQuiz();
          widget.scoreBloc.add(AddScoreUser(
            mode: widget.mode,
            metaQuiz: widget.correct,
            score: _currentPoint.round(),
            quizId: widget.correct.id,
          ));
          Navigator.of(context).pop();
        },
        confirmColor: greenColor,
        cancelAble: false,
      );

    } else {
      setState(() {
        _recentAnswers.add(_currentAnswer);
        _currentPoint = _currentPoint - (SCORE_BASE / FAIL_TOLERANCE);
        _currentAnswer = '';
      });
    }
  }

  List<Widget> buildOptions(List<QuizModel> list) {
    return list
        .asMap()
        .map(
          (i, w) => MapEntry(
            i,
            CardAnswer(
              loading: _loading,
              item: w,
              answerId: _getAnswerIndex(i),
              answerMode: widget.mode,
              currentAnswer: _currentAnswer == _getAnswerIndex(i),
              selectAnswer: _selectAnswer,
              disabled: _inCorrectAnswer(_getAnswerIndex(i)),
            ),
          ),
        )
        .values
        .toList();
  }

  Widget _buildLayoutAnswer(List<Widget> child) {
    if (widget.mode == GameMode.ArabGambar) {
      return Container(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: child,
        ),
      );
    }
    return Container(
      child: Column(
        children: child,
      ),
    );
  }

  Widget buildQuiz(_deviceHeight, listQuiz) {
    return Container(
      height: 0.6 * _deviceHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLayoutAnswer(buildOptions(listQuiz)),
          Padding(
            padding: const EdgeInsets.only(
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
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CardQuiz(
            currentPoint: _currentPoint,
            isCorrect: _isCorrect,
            loading: _loading,
            deviceHeight: widget.deviceHeight,
            quiz: widget.correct,
            mode: widget.mode,
          ),
          _isCorrect
              ? Congratulation(
                  isCorrect: _isCorrect,
                  onNewGame: _getQuiz,
                  point: _currentPoint.round(),
                )
              : buildQuiz(widget.deviceHeight, widget.list)
        ],
      ),
    );
  }
}
