import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/home/view/home_screen.dart';

class CardPlain extends StatelessWidget {
  final double height;
  final Color color;
  final Color secondaryColor;
  CardPlain({ this.height = 200, this.color = greyColor, this.secondaryColor = softGreyColor });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: secondaryColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: color,
          ),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10.0,
                left: 10.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(HomeScreen.routeName);
                  },
                  child: Padding(padding: const EdgeInsets.all(5.0),child: Icon(Icons.keyboard_backspace, size: 30.0, color: Colors.white),),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                width: MediaQuery.of(context).size.width,
                height: height,
              )
            ],
          ),
        )
      ],
    );
  }
}
