import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:karbarab/core/ui/cards/card_image.dart';
import 'package:karbarab/core/ui/cards/card_text.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

class CardGame extends StatefulWidget {
  final bool correct;
  final int point;
  final double height;
  final bool loading;
  final QuizModel quiz;
  final GameMode mode;
  final Function rewarded;
  CardGame({
    this.correct,
    this.point,
    this.height = 200,
    this.loading = false,
    @required this.rewarded,
    @required this.quiz,
    @required this.mode,
  });

  @override
  _CardGameState createState() => _CardGameState();
}

class _CardGameState extends State<CardGame>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.addStatusListener((AnimationStatus status) {
      if (!_focusNode.hasFocus && _animationController.isCompleted) {
        setState(() {
          FocusScope.of(context).requestFocus(_focusNode);
        });
      } else if (_focusNode.hasFocus && !_animationController.isCompleted) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _cardModeFront(context) {
    switch (widget.mode) {
      case GameMode.GambarArab:
        return CardImage(
        loading: widget.loading,
        quiz: widget.quiz,
        height: widget.height,
        point: widget.point,
      );
      case GameMode.ArabGambar:
        return CardText(
        loading: widget.loading,
        text: widget.quiz.arab,
        voice: widget.quiz.arabVoice,
        height: widget.height,
        point: widget.point,
        isCorrect: widget.correct,
        rewarded: widget.rewarded,
        answerMode: _getMode(widget.mode),
      );
      case GameMode.ArabKata:
        return CardText(
        loading: widget.loading,
        text: widget.quiz.arab,
        voice: widget.quiz.arabVoice,
        height: widget.height,
        isCorrect: widget.correct,
        rewarded: widget.rewarded,
        point: widget.point,
        answerMode: _getMode(widget.mode),
      );
      case GameMode.KataArab:
        return CardText(
        loading: widget.loading,
        text: widget.quiz.bahasa,
        height: widget.height,
        isCorrect: widget.correct,
        rewarded: widget.rewarded,
        point: widget.point,
        answerMode: _getMode(widget.mode),
      );
    }
    return const Text('warn front');
  }

  Widget _cardModeBack(context) {
    switch (widget.mode) {
      case GameMode.GambarArab:
        return CardText(
        loading: widget.loading,
        text: widget.quiz.arab,
        voice: widget.quiz.arabVoice,
        height: widget.height,
        isCorrect: widget.correct,
        rewarded: widget.rewarded,
        point: widget.point,
        answerMode: _getMode(widget.mode, flip: true),
      );
      case GameMode.ArabGambar:
        return CardImage(
        loading: widget.loading,
        quiz: widget.quiz,
        height: widget.height,
        point: widget.point,
      );
      case GameMode.ArabKata:
        return CardText(
        loading: widget.loading,
        text: widget.quiz.bahasa,
        height: widget.height,
        point: widget.point,
        isCorrect: widget.correct,
        rewarded: widget.rewarded,
        answerMode: _getMode(widget.mode, flip: true),
      );
      case GameMode.KataArab:
        return CardText(
        loading: widget.loading,
        text: widget.quiz.arab,
        voice: widget.quiz.arabVoice,
        height: widget.height,
        isCorrect: widget.correct,
        rewarded: widget.rewarded,
        point: widget.point,
        answerMode: _getMode(widget.mode, flip: true),
      );
    }
    return const Text('warn back');
  }

  Widget _buildFront(context) {
    if (widget.correct) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return CardContainer(
      child: _cardModeFront(context),
    );
  }

  Widget _buildBack(context) {
    return CardContainer(
      child: _cardModeBack(context),
    );
  }

  Widget _buildMessage(BuildContext context) {
    if (widget.correct) {
      return RegularText(text: winWords(widget.point), dark: false);
    }
    return RegularText(text: 'Jawab soal ini dengan benar', dark: false);
  }

  CardAnswerMode _getMode(GameMode mode, { bool flip = false }) {
    switch(mode) {
      case GameMode.ArabGambar:
        return flip ? CardAnswerMode.Latin : CardAnswerMode.Arab;
      case GameMode.ArabKata:
        return flip ? CardAnswerMode.Latin : CardAnswerMode.Arab;
      case GameMode.GambarArab:
        return flip ? CardAnswerMode.Arab : CardAnswerMode.Latin;
      case GameMode.KataArab:
        return flip ? CardAnswerMode.Arab : CardAnswerMode.Latin;
    }
    return CardAnswerMode.Latin;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25.0),
          child: Center(
            child: _buildMessage(context),
          ),
        ),
        FlipView(
          animationController: _curvedAnimation,
          front: _buildFront(context),
          back: _buildBack(context),
        ),
      ],
    );
  }
}

class CardContainer extends StatelessWidget {
  final Widget child;

  CardContainer({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 30,
        right: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: textColor.withOpacity(0.2),
            blurRadius: 20.0,
            spreadRadius: 0.0,
            offset: const Offset(
              2.0,
              10.0,
            ),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }
}

