import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:karbarab/features/voices/bloc/voices_bloc.dart';

class Speech extends StatefulWidget {
  final String id;
  final String arab;
  Speech({Key key, @required this.id, @required this.arab}) : super(key: key);

  @override
  _SpeechState createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  AudioPlayer audioPlugin = AudioPlayer();

  void _play() {
    BlocProvider.of<VoicesBloc>(context).add(StopSpeech());
    BlocProvider.of<VoicesBloc>(context).add(GetSpeech(widget.id, widget.arab));
  }

  @override
  void initState() {
    audioPlugin.onPlayerCompletion.listen((event) {
      getLogger('Audio').w('complete');
      BlocProvider.of<VoicesBloc>(context).add(StopSpeech());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<VoicesBloc, VoicesState>(
        listener: (context, state) {
          if (state is HasSpeech && state.id == widget.id) {
            audioPlugin.play(state.path);
          }
        },
        child: GestureDetector(
          onTap: _play,
          child: Icon(
            Icons.volume_up,
            color: greyColor,
            size: 40.0,
          ),
        ),
      ),
    );
    // return Container(
    //   child: BlocBuilder<VoicesBloc, VoicesState>(
    //     builder: (context, state) {
    //       getLogger('Speech Widget').i(state);
    //       return GestureDetector(
    //         onTap: _play,
    //         child: Icon(
    //           Icons.volume_up,
    //           color: greyColor,
    //           size: 40.0,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
