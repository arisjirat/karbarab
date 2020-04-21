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
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    RegularText(text: 'Kartu: ',),
                    RegularText(text: score.metaQuiz.bahasa, bold: true,),
                  ],),
                  const SizedBox(height: 10),
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
                          : const SizedBox(
                              width: 0,
                            ),
                      const SizedBox(width: 10),
                      RegularText(text: score.usernameSender,)
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
              height: 100,
              color: score.isSolved ? greyColor : greenColor,
              child: RegularText(text: 'Jawab', dark: false,),
            ),
          ],
        ),
      ),
    );
  }
}
