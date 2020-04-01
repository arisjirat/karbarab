import 'package:flutter/material.dart';
import 'package:karbarab/core/ui/typography.dart';

class GameModeChooser extends StatelessWidget {
  const GameModeChooser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RegularText(text: 'mode chooser',),
    );
  }
}