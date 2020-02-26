import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/screens/home_screen.dart';

class CardPlain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: greyColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: softGreyColor,
          ),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10.0,
                right: 10.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(HomeScreen.routeName);
                  },
                  child: Icon(Icons.keyboard_backspace, size: 30.0, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                width: MediaQuery.of(context).size.width,
                height: 250.00,
              )
            ],
          ),
        )
      ],
    );
  }
}
