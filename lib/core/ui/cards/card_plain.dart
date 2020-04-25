import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/popup.dart';
import 'package:flutter/widgets.dart';

class CardPlain extends StatelessWidget {
  final Function confirmClose;
  final double height;
  final Color color;
  final Color backColor;
  CardPlain({
    @required this.confirmClose,
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
                      text: 'Yakin keluar dari quiz ini?',
                      cancel: () {
                        Navigator.of(context).pop();
                      },
                      confirm: () {
                        confirmClose();
                      },
                      cancelAble: true,
                      cancelLabel: 'Jangan!',
                      confirmLabel: 'Ya, saya ingin keluar',
                    );
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: secondaryColor,
                  padding: const EdgeInsets.all(15.0),
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
