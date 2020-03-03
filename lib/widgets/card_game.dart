import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/helper/model_quiz.dart';
import 'package:karbarab/widgets/typography.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

class CardGame extends StatefulWidget {
  final bool correct;
  final int point;
  final double height;
  final bool loading;
  final QuizModel quiz;
  CardGame({
    this.correct,
    this.point,
    this.height = 200,
    this.loading = false,
    @required this.quiz,
  });

  @override
  _CardGameState createState() => _CardGameState();
}

class _CardGameState extends State<CardGame>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
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

  Widget _buildFront(context) {
    if (widget.correct) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        bottom: 20.0,
        left: 30,
        right: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: textColor.withOpacity(0.2),
            blurRadius: 20.0,
            spreadRadius: 0.0,
            offset: Offset(
              2.0,
              10.0,
            ),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            height: widget.height - 40,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.loading || widget.quiz == null
                    ? RegularText(text: 'Loading', dark: true)
                    : Image.network(
                        widget.quiz.image,
                        height: 150,
                        fit:BoxFit.fill
                      )
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: SmallerText(
                text: widget.point.toString(),
                dark: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBack(context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        bottom: 20.0,
        left: 30,
        right: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: textColor.withOpacity(0.2),
            blurRadius: 20.0,
            spreadRadius: 0.0,
            offset: Offset(
              2.0,
              10.0,
            ),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            height: widget.height - 40,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.loading
                    ? RegularText(text: 'Loading', dark: true)
                    : BiggerArabicText(
                        text: widget.quiz.arab,
                        dark: true,
                        bold: true,
                      )
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: SmallerText(
                text: widget.point.toString(),
                dark: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    if (widget.correct) {
      return BiggerText(text: 'Yeay kamu hebat!', dark: false);
    }
    return BiggerText(text: 'Jawab soal ini dengan benar', dark: false);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40.0),
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
