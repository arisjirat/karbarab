import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/widgets/typography.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool disabled;

  Button({
    @required this.text,
    @required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: disabled ? greenColor.withOpacity(0.5) : Theme.of(context).primaryColor,
          ),
          width: MediaQuery.of(context).size.width,
          height: 60.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          margin: const EdgeInsets.only(top: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                padding: const EdgeInsets.only(right: 10.0),
                child: BoldRegularText(text: text, dark: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
