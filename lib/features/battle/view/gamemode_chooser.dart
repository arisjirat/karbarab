import 'package:flutter/material.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/ui/typography.dart';

class GameModeChooser extends StatelessWidget {
  final Function(GameMode) onSelect;
  const GameModeChooser({Key key, @required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: RegularText(text: 'ArabGambar',),
          onPressed: () {
            onSelect(GameMode.ArabGambar);
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          child: RegularText(text: 'ArabKata',),
          onPressed: () {
            onSelect(GameMode.ArabKata);
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          child: RegularText(text: 'GambarArab',),
          onPressed: () {
            onSelect(GameMode.GambarArab);
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          child: RegularText(text: 'KataArab',),
          onPressed: () {
            onSelect(GameMode.KataArab);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
