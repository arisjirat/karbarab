import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/config/score_value.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/ui/button_ads_hint.dart';
import 'package:karbarab/core/ui/feedback_form.dart';
import 'package:karbarab/core/ui/popup.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/admob/bloc/admob_bloc.dart';
import 'package:karbarab/features/admob/view/ads.dart';
import 'package:karbarab/features/feedback/bloc/feedback_bloc.dart';
import 'package:karbarab/features/home/view/home_screen.dart';
import 'package:karbarab/features/quiz/bloc/quiz_bloc.dart';
import 'package:karbarab/core/ui/button.dart';
import 'package:karbarab/core/ui/cards/card_answer.dart';
import 'package:karbarab/core/ui/cards/card_quiz.dart';
import 'package:karbarab/core/ui/congratulation.dart';
import 'package:karbarab/features/score/bloc/score_bloc.dart';
import 'package:karbarab/features/voices/view/speech.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';

String _getAnswerIndex(index) {
  const answer = ['A', 'B', 'C', 'D'];
  return answer[index];
}

class GameStartScreen extends StatefulWidget {
  static const String routeName = '/start';
  final GameMode mode;
  GameStartScreen({@required this.mode});

  @override
  _GameStartScreenState createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuizBloc>(context).add(GetQuiz(
        image: widget.mode == GameMode.ArabGambar ||
            widget.mode == GameMode.GambarArab));
  }

  @override
  Widget build(BuildContext context) {
    final QuizBloc quizBloc = BlocProvider.of<QuizBloc>(context);
    final ScoreBloc scoreBloc = BlocProvider.of<ScoreBloc>(context);
    final double _deviceHeight = deviceHeight(context);
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
  final List<Quiz> list;
  final Quiz correct;
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
  bool _hint = false;

  String get _rightAnswer =>
      _getAnswerIndex(widget.list.indexOf(widget.correct));

  bool _inCorrectAnswer(key) {
    return _recentAnswers.contains(key);
  }

  void _handleRewardedHint() {
    setState(() {
      _hint = true;
    });
  }

  void _getQuiz() {
    BlocProvider.of<FeedbackBloc>(context).add(ResetFeedbackQuiz());
    setState(() {
      _currentPoint = SCORE_BASE;
      _loading = true;
      _isCorrect = false;
      _currentAnswer = '';
      _recentAnswers = [];
      _hint = false;
    });
    Timer(const Duration(milliseconds: 500), () {
      widget.quizBloc.add(GetQuiz(
          image: widget.mode == GameMode.ArabGambar ||
              widget.mode == GameMode.GambarArab));
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
    if (_currentAnswer == '') {
    } else if (_rightAnswer == _currentAnswer && _currentAnswer != '') {
      setState(() {
        _isCorrect = true;
      });
      widget.scoreBloc.add(AddScoreUser(
        mode: widget.mode,
        metaQuiz: widget.correct,
        score: _currentPoint,
        quizId: widget.correct.id,
      ));
    } else if (_recentAnswers.length > 1) {
      widget.scoreBloc.add(AddScoreUser(
        mode: widget.mode,
        metaQuiz: widget.correct,
        score: _currentPoint,
        quizId: widget.correct.id,
      ));
      popup(
        context,
        text: 'Kesempatan Kamu habis',
        confirmLabel: 'Kartu Selanjutnya',
        cancel: () {
          Navigator.of(context).pop();
        },
        confirm: () {
          _getQuiz();
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

  void _giveFeedback() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: BoldRegularText(
              text: 'Beritahu koreksi kamu',
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            side: BorderSide(color: greenColor, width: 2),
          ),
          titlePadding: const EdgeInsets.symmetric(vertical: 20),
          content: BlocBuilder<FeedbackBloc, FeedbackState>(
            builder: (context, state) {
              return FeedbackForm(
                onBack: Navigator.of(context).pop,
                onSubmit: (String shouldBe) async {
                  BlocProvider.of<FeedbackBloc>(context).add(
                    AddFeedbackQuiz(
                      quizId: widget.correct.id,
                      shouldBe: shouldBe,
                      notes: '',
                      quizMode: widget.mode,
                      metaQuiz: widget.correct,
                    ),
                  );
                },
                isLoading: state is FeedbackState && state.isLoading,
                isSuccess: state is FeedbackState && state.isSuccess,
                isFailure: state is FeedbackState && state.isFailure,
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> buildOptions(List<Quiz> list) {
    return list
        .asMap()
        .map(
          (i, w) => MapEntry(
            i,
            CardAnswer(
              loading: _loading,
              item: w,
              hint: _hint && (_rightAnswer == _getAnswerIndex(i)),
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
        return false;
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardQuiz(
                confirmClose: () {
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                },
                currentPoint: _currentPoint,
                isCorrect: _isCorrect,
                loading: _loading,
                deviceHeight: widget.deviceHeight,
                quiz: widget.correct,
                mode: widget.mode,
                adsHint: AdsScreen(
                  adsMode: AdsMode.HINT,
                  onReward: _handleRewardedHint,
                  buttonShow: const ButtonAdsHint(),
                ),
                giveFeedback: _giveFeedback,
                speech:
                    Speech(id: widget.correct.id, arab: widget.correct.arab),
              ),
              _isCorrect
                  ? Congratulation(
                      nextWord: 'Kata Selanjutnya',
                      isCorrect: _isCorrect,
                      onNewGame: _getQuiz,
                      point: _currentPoint,
                    )
                  : buildQuiz(widget.deviceHeight, widget.list)
            ],
          ),
        ),
      ),
    );
  }
}
