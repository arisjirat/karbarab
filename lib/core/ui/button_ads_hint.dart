import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';

class ButtonAdsHint extends StatelessWidget {
  const ButtonAdsHint({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(3.0),
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.vpn_key, size: 20, color: greenColor),
          ),
          SmallerText(
            text: 'Jawaban',
            dark: false,
            bold: true,
          ),
        ],
      ),
    );
  }
}
