import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';

class CardScoreItem extends StatefulWidget {
  final ScoreGlobalModel score;
  final int tier;
  const CardScoreItem({Key key, @required this.score, @required this.tier})
      : super(key: key);

  @override
  _CardScoreItemState createState() => _CardScoreItemState();
}

class _CardScoreItemState extends State<CardScoreItem> {

  bool expanded = false;

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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.score.metaUser.avatar,
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
                      text: widget.score.metaUser.fullname,
                      dark: true,
                    ),
                    BoldRegularText(
                      text: widget.score.score.toString(),
                      dark: false,
                      color: greenColor,
                    ),
                  ],
                )
              ],
            ),
            Icon(
              Icons.stars,
              color: getColor(widget.tier),
            ),
          ],
        ),
      ),
    );
  }
}
