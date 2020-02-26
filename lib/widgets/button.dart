import 'package:flutter/material.dart';
import 'package:karbarab/widgets/typography.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onTap;

  Button({
    @required this.text,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final arabMode = answerMode == ButtonMode.Arab;
    return GestureDetector(
      onTap: () {
        this.onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).primaryColor,
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
