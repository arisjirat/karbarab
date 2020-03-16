import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/core/config/colors.dart';

class PointCard extends StatefulWidget {
  final int point;
  PointCard(this.point);

  @override
  _PointCardState createState() => _PointCardState();
}

class _PointCardState extends State<PointCard> {
  AnimationController animateController;
  AnimationStatus animationStatus = AnimationStatus.completed;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PointCard oldWidget) {
    if (oldWidget.point != widget.point) {
      animateController.forward(
        from: 0.0,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: Dance(
        manualTrigger: true,
        duration: const Duration(milliseconds: 300),
        controller: (controller) => animateController = controller,
        child: Container(
          height: 25,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: SmallerText(
            text: widget.point.toString(),
            dark: false,
          ),
        ),
      ),
    );
  }
}
