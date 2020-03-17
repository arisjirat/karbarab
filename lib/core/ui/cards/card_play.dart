import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/quiz/view/game_start_screen.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CardPlay extends StatelessWidget {
  final Color color;
  final Color secondaryColor;
  final String title;
  final double score;
  final bool loadScore;
  final GameMode mode;

  CardPlay({
    this.color,
    this.secondaryColor,
    this.title,
    this.score,
    this.loadScore,
    this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameStartScreen(mode: mode),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0.0),
              width: MediaQuery.of(context).size.width,
              height: 20.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: secondaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: color,
              ),
              width: MediaQuery.of(context).size.width,
              height: 80.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              margin: const EdgeInsets.only(top: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BoldRegularText(text: title, dark: false),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              height: 29,
                              margin: const EdgeInsets.only(top: 5.0),
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 15.0,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: textColor.withOpacity(0.5),
                                    offset: const Offset(0.0, 0.0),
                                  ),
                                  BoxShadow(
                                    color: textColor.withOpacity(0.5),
                                    offset: const Offset(0.0, 0.1),
                                    spreadRadius: -2.0,
                                    blurRadius: 5.0,
                                  ),
                                ],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                            ),
                            ScoreContainer(score: score.roundToDouble(), color: secondaryColor, loadScore: loadScore),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: loadScore
                                  ? SpinKitWave(
                                      color: Colors.white,
                                      size: 15.0,
                                    )
                                  : SmallerText(
                                      text: score > 0
                                          ? 'Nilai kamu ${score.toStringAsPrecision(2)}/10'
                                          : 'Kamu belum main',
                                      dark: false,
                                    ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Image(
                      image: AssetImage(
                        'assets/images/neutral_triangle_right.png',
                      ),
                      height: 35.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScoreContainer extends StatefulWidget {
  final double score;
  final Color color;
  final bool loadScore;
  ScoreContainer({ @required this.score, this.color, @required this.loadScore});

  @override
  _ScoreContainerState createState() => _ScoreContainerState();
}

class _ScoreContainerState extends State<ScoreContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    final Animation curve =
    CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    animation = IntTween(begin: 0,
      end: 200,
    ).animate(curve)
    ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(ScoreContainer oldWidget) {
    if (oldWidget.loadScore != widget.loadScore) {
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.score * 10) * animation.value / 100,
      height: 29,
      margin: const EdgeInsets.only(top: 5.0),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 15.0,
      ),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
    );
  }
}
