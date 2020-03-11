import 'dart:async';
import 'package:flutter/material.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/widgets/typography.dart';
import 'package:karbarab/core/config/colors.dart';

import 'package:flutter/services.dart';

class AudioPlayer {
  static const MethodChannel _channel = MethodChannel('audio_player');

  static Future addSound(String path) async {
    return await _channel.invokeMethod('addSound', path);
  }

  static Future removeAllSound() async {
    return await _channel.invokeMethod('removeAllSound');
  }
}


class CardText extends StatefulWidget {
  final int point;
  final String text;
  final String voice;
  final double height;
  final bool loading;
  final CardAnswerMode answerMode;

  CardText({
    @required this.point,
    @required this.text,
    @required this.height,
    @required this.loading,
    @required this.answerMode,
    this.voice = '',
  });

  @override
  _CardTextState createState() => _CardTextState();
}

class _CardTextState extends State<CardText> {

  @override
  void initState() {
    super.initState();
  }

  void _play() {
    if (!widget.loading) {
      SoundPlayerUtil.addSoundName(widget.voice);
    }
  }

  @override
  void dispose() {
    super.dispose();
    SoundPlayerUtil.removeAllSound();
  }

  Widget _buildText() {
    if (widget.answerMode == CardAnswerMode.Arab) {
      return BiggerArabicText(text: widget.text ,dark: true,);
    }
    return LargerText(text: widget.text, dark: true, bold: true, );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.height - 80,
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.loading
                  ? RegularText(text: 'Loading', dark: true)
                  : _buildText()
            ],
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
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
        Positioned(
          top: 20.0,
          right: 20.0,
          child: widget.answerMode == CardAnswerMode.Arab ? GestureDetector(
            onTap: _play,
            child: Icon(
              Icons.volume_up,
              color: greyColor,
              size: 40.0,
            ),
          ) : const Text(''),
        )
      ],
    );
  }
}

class SoundPlayerUtil {
  static void addSoundName(String name, {int count = 1}) {
    for (var i = 0; i < count; i++) {
      AudioPlayer.addSound('assets/voices/' + name);
    }
  }

  static void removeAllSound() {
    AudioPlayer.removeAllSound();
  }
}