import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/ui/typography.dart';

import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:karbarab/model/user.dart';

class CardScoreItem extends StatelessWidget {
  final ScoreGlobalModel score;
  final int tier;
  const CardScoreItem({Key key, @required this.score, @required this.tier})
      : super(key: key);

  Color getColor(int position) {
    switch (position) {
      case 1:
        return yellowColor;
      case 2:
        return greyColor;
      case 3:
        return brownColor;
      default:
        return greyColorLight;
    }
  }

  void onClickScore(BuildContext context, User user) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: BoldRegularText(
              text: score.metaUser.username,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            side: BorderSide(color: greenColor, width: 2),
          ),
          titlePadding: const EdgeInsets.only(top: 10),
          content: Container(
            width: 0.8 * MediaQuery.of(context).size.height,
            height: 0.75 * deviceHeight(context),
            child: ListView.builder(
              itemCount: score.scoreHistory.length,
              itemBuilder: (context, position) {
                final DateTime date = score.scoreHistory[position].createdAt;
                final String addWord = score.scoreHistory[position].isBattle ? 'kartu kiriman | ' : ''; 
                if (user.id != score.scoreHistory[position].userId) {
                  return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RegularText(
                              text: score.scoreHistory[position].metaQuiz.bahasa,
                              dark: true,
                            ),
                            TinyText(
                              text: 'mengirim | ${date.day}-${date.month}-${date.year}, ${date.hour}:${date.minute} ',
                              dark: true,
                            )
                          ],
                        ),
                        BoldRegularText(
                          text: score.scoreHistory[position].userSenderScore.toString(),
                          color: score.scoreHistory[position].userSenderScore > 0 ? greenColor : redColor,
                        ),
                      ],
                    ),
                  ),
                );
                }
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RegularText(
                              text: score.scoreHistory[position].metaQuiz.bahasa,
                              dark: true,
                            ),
                            TinyText(
                              text: '$addWord${date.day}-${date.month}-${date.year}, ${date.hour}:${date.minute}',
                              dark: true,
                            )
                          ],
                        ),
                        BoldRegularText(
                          text: score.scoreHistory[position].score.toString(),
                          color: score.scoreHistory[position].score >= 0 ? greenColor : redColor
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => onClickScore(context, score.metaUser),
      onTap: () => onClickScore(context, score.metaUser),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BoldRegularText(
                    text: tier.toString(),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  score.metaUser.avatar != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            score.metaUser.avatar,
                          ),
                          radius: 20,
                          backgroundColor: Colors.transparent,
                        )
                      : const CircleAvatar(
                          radius: 20,
                          backgroundColor: greenColor,
                          backgroundImage:
                              AssetImage('assets/images/character.png'),
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RegularText(
                        text: score.metaUser.username,
                        dark: true,
                      ),
                      BoldRegularText(
                        text: score.score.toInt().toString(),
                        dark: false,
                        color: greenColor,
                      ),
                    ],
                  )
                ],
              ),
              Icon(
                Icons.stars,
                color: getColor(tier),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardUserAction extends StatelessWidget {
  final User users;
  final Function(User) onTap;
  const CardUserAction({Key key, @required this.users, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: MaterialButton(
        padding: const EdgeInsets.all(15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          side: BorderSide(color: greenColor, width: 2),
        ),
        focusColor: greenColorLight,
        onPressed: () {
          onTap(users);
        },
        child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              users.avatar != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        users.avatar,
                      ),
                      radius: 20,
                      backgroundColor: Colors.transparent,
                    )
                  : const CircleAvatar(
                      radius: 20,
                      backgroundColor: greenColor,
                      backgroundImage:
                          AssetImage('assets/images/character.png'),
                    ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldRegularText(
                    text: users.username,
                    dark: true,
                  ),
                ],
              )
            ],
          ),
      ),
    );
  }
}
