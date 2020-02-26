import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';
// import 'package:karbarab/screens/game_start_screen.dart';
// import 'package:karbarab/widgets/button.dart';
import 'package:karbarab/widgets/typography.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

class CardGame extends StatefulWidget {
  final bool correct;
  final double point;
  CardGame({
    this.correct,
    this.point,
  });

  // DeveloperLibsWidget({
  //   Key key,
  //   this.parameter,
  // }) : super(key: key);
  // final parameter;

  @override
  _CardGameState createState() => _CardGameState();
}

class _CardGameState extends State<CardGame>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  FocusNode _focusNode = FocusNode();
  bool _localCorrect;

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
  

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Widget _buildFront(context) {
    if (widget.correct) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: textColor.withOpacity(0.2),
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 0.0, // has the effect of extending the shadow
            offset: Offset(
              2.0, // horizontal, move right 5
              10.0, // vertical, move down 10
            ),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
      child: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Image(image: AssetImage('table.png')),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: textColor.withOpacity(0.2),
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 0.0, // has the effect of extending the shadow
            offset: Offset(
              2.0, // horizontal, move right 5
              10.0, // vertical, move down 10
            ),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
      child: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ArabicText(text: 'كتاكتاكتاب', dark: true),
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
                text: '300',
                dark: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(children: [
      FlipView(
        animationController: _curvedAnimation,
        front: _buildFront(context),
        back: _buildBack(context),
      ),
      Container(
          width: 200,
          child: Row(
            children: [
              RaisedButton(
                onPressed: () {
                  _flip(true);
                },
                child: Text(
                  'Front',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _flip(false);
                },
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              // ButtonBar(text: 'back', onTap: () { _flip(true); }),
              // ButtonBar(text: 'front', onTap: () { _flip(false); }),
            ],
          )),
    ]);
  }
}
