import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/model/score.dart';

class CardBattleItem extends StatelessWidget {
  final Score score;
  final Function onAnswer;
  const CardBattleItem({
    Key key,
    @required this.onAnswer,
    @required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RegularText(
                        text: 'Mode: ',
                      ),
                      RegularText(
                        text: GameModeHelper.stringOf(score.quizMode),
                        bold: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      score.userAvatarSender != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                score.userAvatarSender,
                              ),
                              radius: 20,
                              backgroundColor: Colors.transparent,
                            )
                          : const CircleAvatar(
                              radius: 20,
                              backgroundColor: whiteColor,
                              backgroundImage:
                                  AssetImage('assets/images/character.png'),
                            ),
                      const SizedBox(width: 10),
                      RegularText(
                        text: score.usernameSender,
                      )
                    ],
                  )
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                if (!score.isSolved) {
                  onAnswer();
                  return;
                }
              },
              height: 90,
              elevation: score.isSolved ? 0 : 2,
              color: score.isSolved ? greyColor : greenColor,
              child: RegularText(
                text: score.isSolved ? score.score.toInt().toString() : 'Jawab',
                dark: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
