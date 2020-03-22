import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/popup.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/home/view/home_screen.dart';
import 'package:flutter/widgets.dart';

class CardPlain extends StatelessWidget {
  final double height;
  final Color color;
  final Color backColor;
  CardPlain({
    this.height = 200,
    this.color = greyColor,
    this.backColor = softGreyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: backColor,
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
                  top: 5.0,
                  left: -15.0,
                  child: RawMaterialButton(
                    onPressed: () {
                      popup(
                        context,
                        text: 'Yakin keluar game?',
                        cancel: () {
                          Navigator.of(context).pop();
                        },
                        confirm: () {
                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        },
                        cancelAble: true,
                        cancelLabel: 'Jangan!',
                        confirmLabel: 'Ya, saya ingin keluar',
                      );
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: secondaryColor,
                    padding: const EdgeInsets.all(15.0),
                  )
                  // child: RaisedButton(
                  //   color: secondaryColor,
                  //   padding: const EdgeInsets.all(0),
                  //   elevation: 10,
                  //   onPressed: () {
                  //     popup(
                  //       context,
                  //       text: 'Yakin keluar game?',
                  //       cancel: () {
                  //         Navigator.of(context).pop();
                  //       },
                  //       confirm: () {
                  //         Navigator.of(context).pushNamed(HomeScreen.routeName);
                  //       },
                  //       cancelAble: true,
                  //       cancelLabel: 'Jangan!',
                  //       confirmLabel: 'Ya, saya ingin keluar',
                  //     );
                  //   },
                  //   child: RegularText(
                  //     text: 'X',
                  //     dark: false,
                  //   ),
                  // ),
                  // ),
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
