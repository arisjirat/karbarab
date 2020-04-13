import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/voices/view/speech.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';

class CardItem extends StatelessWidget {
  final Quiz quiz;
  final GameMode gameMode;
  final bool extra;
  final int totalScore;
  final double averageScore;
  final bool positive;
  const CardItem({
    Key key,
    @required this.quiz,
    this.positive,
    this.extra = true,
    this.totalScore,
    this.averageScore,
    this.gameMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            !extra
                ? BoldRegularText(text: quiz.bahasa, dark: true)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      quiz.image == '' || quiz.image == null
                          ? Column(
                              children: <Widget>[
                                const Image(
                                  image:
                                      AssetImage('assets/images/no-photo.jpg'),
                                  height: 30,
                                ),
                                TinyText(text: 'tidak ada gambar', dark: true)
                              ],
                            )
                          : Image(
                              image: AssetImage('assets/quiz/${quiz.image}'),
                              height: 60,
                              fit: BoxFit.fill,
                            ),
                      const SizedBox(height: 10),
                      BoldRegularText(text: quiz.bahasa, dark: true),
                    ],
                  ),
            !extra
                ? BoldRegularText(text: quiz.arab, dark: true)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Speech(
                        id: quiz.id,
                        arab: quiz.arab,
                      ),
                      const SizedBox(height: 5),
                      BoldRegularText(text: quiz.arab, dark: true),
                      const SizedBox(height: 5),
                      extra
                          ? Container(
                              color: positive ? greenColor : redColor,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    color: secondaryColor,
                                    child: SmallerText(
                                        text: GameModeHelper.stringOf(gameMode),
                                        dark: false,
                                        bold: true),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: SmallerText(
                                      text: (averageScore * 100)
                                          .round()
                                          .toString(),
                                      dark: false,
                                      bold: true,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(width: 10),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

class CardItemAction extends StatelessWidget {
  final Quiz quiz;
  final Function(Quiz) onTap;
  CardItemAction({@required this.quiz, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(10),
      onPressed: () {
        onTap(quiz);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BoldRegularText(text: quiz.bahasa, dark: true),
          BoldRegularText(text: quiz.arab, dark: true),
        ],
      ),
    );
  }
}
