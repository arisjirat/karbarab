import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/model/score.dart';

class GameModeChooser extends StatelessWidget {
  final Function(GameMode) onSelect;
  const GameModeChooser({Key key, @required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 90),
        BiggerText(text: 'Pilih Mode yang akan kamu berikan', dark: true,),
        const SizedBox(height: 30),
        RaisedButton(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          color: greenColorLight,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          side: BorderSide(color: greenColor, width: 2),
        ),
        focusColor: greenColorLight,
          child: RegularText(text: 'Arab => Gambar', dark: false,),
          onPressed: () {
            onSelect(GameMode.ArabGambar);
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: 15),
        RaisedButton(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          color: greenColorLight,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          side: BorderSide(color: greenColor, width: 2),
        ),
        focusColor: greenColorLight,
          child: RegularText(text: 'Arab => Bahasa', dark: false,),
          onPressed: () {
            onSelect(GameMode.ArabKata);
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: 15),
        RaisedButton(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          color: greenColorLight,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          side: BorderSide(color: greenColor, width: 2),
        ),
        focusColor: greenColorLight,
          child: RegularText(text: 'Gambar => Arab', dark: false,),
          onPressed: () {
            onSelect(GameMode.GambarArab);
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: 15),
        RaisedButton(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          color: greenColorLight,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          side: BorderSide(color: greenColor, width: 2),
        ),
        focusColor: greenColorLight,
          child: RegularText(text: 'Bahasa => Arab', dark: false,),
          onPressed: () {
            onSelect(GameMode.KataArab);
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
