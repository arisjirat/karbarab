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
  final String voice;
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
    @required this.voice,
    @required this.image,
    @required this.totalScore,
    @required this.averageScore,
    @required this.gameMode,
  }) : super(key: key);

  void _play() {
    SoundPlayerUtil.addSoundName(voice);
  }

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image == ''
                    ? Column(
                      children: <Widget>[
                        const Image(
                        image: AssetImage('assets/images/no-photo.jpg'),
                        height: 30,
                      ),
                      TinyText(text: 'tidak ada gambar', dark: true)
                      ],
                    )
                    : Image.network(
                        image,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 5),
                BoldRegularText(text: arab, dark: true),
                const SizedBox(height: 5),
                Container(
                  color: positive ? greenColor : redColor,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        color: secondaryColor,
                        child: SmallerText(
                            text: gameModeToString(gameMode),
                            dark: false,
                            bold: true),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: SmallerText(
                          text: (averageScore * 100).round().toString(),
                          dark: false,
                          bold: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
