import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/model/user.dart';

class CardBattleItem extends StatelessWidget {
  final User user;
  final Score score;
  final Function onAnswer;
  const CardBattleItem({
    Key key,
    @required this.onAnswer,
    @required this.score,
    @required this.user,
  }) : super(key: key);

  bool get isReciever {
    return score.userId == user.id;
  }

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
                      isReciever
                          ? RegularText(
                              text: 'Mode: ',
                            )
                          : RegularText(
                              text: 'Kartu: ',
                            ),
                      isReciever
                          ? RegularText(
                              text: GameModeHelper.stringOf(score.quizMode),
                              bold: true,
                            )
                          : RegularText(
                              text: score.metaQuiz.bahasa,
                              bold: true,
                            ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      !isReciever
                          ? score.metaUser.avatar != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(score.metaUser.avatar),
                                  radius: 20,
                                  backgroundColor: Colors.transparent,
                                )
                              : const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: whiteColor,
                                  backgroundImage:
                                      AssetImage('assets/images/character.png'),
                                )
                          : score.userAvatarSender != null
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegularText(
                            text: !isReciever
                                ? score.metaUser.username
                                : score.usernameSender,
                          ),
                          SmallerText(
                            color: isReciever ? redColor : greenColor,
                            text: !isReciever ? 'terkirim' : 'menyerang',
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            isReciever
                ? MaterialButton(
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
                      text: score.isSolved
                          ? score.score.toInt().toString()
                          : 'Jawab',
                      dark: false,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: score.isSolved && score.score < 0
                          ? greenColor
                          : !score.isSolved ? secondaryColor : redColor,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(score.isSolved ? 20 : 30),
                    child: score.isSolved
                        ? RegularText(
                            color: whiteColor,
                            text: score.userSenderScore.toInt().toString(),
                          )
                        : SmallerText(
                            color: whiteColor,
                            text: '-',
                          ))
          ],
        ),
      ),
    );
  }
}
