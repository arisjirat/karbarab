import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';

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

  void onClickScore(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: BoldRegularText(
              text: score.userMail,
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
                final DateTime date = score.scoreHistory[position].date;
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
                              text: score.scoreHistory[position].bahasa,
                              dark: true,
                            ),
                            TinyText(
                              text: '${date.day}-${date.month}-${date.year}',
                              dark: true,
                            )
                          ],
                        ),
                        BoldRegularText(
                          text: score.scoreHistory[position].score.toString(),
                          color: greenColor,
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
      onDoubleTap: () => onClickScore(context),
      onTap: () => onClickScore(context),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BoldRegularText(text: tier.toString(),),
                  const SizedBox(width: 15,),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      score.metaUser.avatar,
                    ),
                    radius: 20,
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RegularText(
                        text: score.metaUser.fullname,
                        dark: true,
                      ),
                      BoldRegularText(
                        text: score.score.toString(),
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
