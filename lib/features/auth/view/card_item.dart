import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/core/ui/cards/card_text.dart';
import 'package:karbarab/core/ui/typography.dart';

class CardItem extends StatelessWidget {
  final String bahasa;
  final String id;
  final String arab;
  final String arabVoice;
  final String image;
  final GameMode gameMode;
  final int totalScore;
  final double averageScore;
  final bool positive;
  const CardItem({
    Key key,
    @required this.positive,
    @required this.bahasa,
    @required this.id,
    @required this.arab,
    @required this.arabVoice,
    @required this.image,
    @required this.totalScore,
    @required this.averageScore,
    @required this.gameMode,
  }) : super(key: key);

  void _play() {
    SoundPlayerUtil.addSoundName(arabVoice);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  image,
                  height: 60,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 20),
                BoldRegularText(text: bahasa, dark: true),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _play,
                  child: Icon(
                    Icons.volume_up,
                    color: textColor,
                    size: 40.0,
                  ),
                ),
                const SizedBox(height: 10),
                BoldRegularText(text: arab, dark: true),
                const SizedBox(height: 10),
                Container(
                  color: positive ? greenColor : redColor,
                  child: Row(
                    children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: secondaryColor,
                      child: SmallerText(text: gameModeToString(gameMode), dark: false, bold: true),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: SmallerText(text: (averageScore * 100).round().toString(), dark: false, bold: true,),
                    ),
                  ],),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
