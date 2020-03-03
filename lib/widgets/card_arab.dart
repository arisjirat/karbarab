import 'package:flutter/material.dart';
import 'package:karbarab/helper/model_quiz.dart';
import 'package:karbarab/widgets/typography.dart';
import 'package:karbarab/config/colors.dart';

import 'package:audioplayer/audioplayer.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
// import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

enum PlayerState { stopped, playing, paused }

typedef void OnError(Exception exception);

const kUrl = "http://zapsplat.net/zapsplat-sounds/download.php?fileName=zapsplat_human_boy_aged_9_yawn_002_27846.mp3";
// const kUrl2 = "http://www.rxlabz.com/labz/audio.mp3";


class CardArab extends StatefulWidget {
  final int point;
  final QuizModel quiz;
  final double height;
  final bool loading;

  CardArab({
    @required this.point,
    @required this.quiz,
    @required this.height,
    @required this.loading,
  });

  @override
  _CardArabState createState() => _CardArabState();
}

class _CardArabState extends State<CardArab> {
  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = new AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  Future _play() async {
    await audioPlayer.play(localFilePath, isLocal: true);
    setState(() => playerState = PlayerState.playing);
  }

  Future play() async {
    await audioPlayer.play(kUrl);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future _playLocal() async {
    await audioPlayer.play(localFilePath, isLocal: true);
    setState(() => playerState = PlayerState.playing);
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = new Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }
  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on ClientException {
      rethrow;
    }
    return bytes;
  }

  Future _loadFile() async {
    final bytes = await _loadFileBytes(kUrl,
        onError: (Exception exception) =>
            print('_loadFile => exception $exception'));

    final dir = await getApplicationDocumentsDirectory();
    final file = new File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists())
      setState(() {
        localFilePath = file.path;
      });
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Stack(
  //     children: [
  //       Container(
  //         height: widget.height - 40,
  //         padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
  //         width: MediaQuery.of(context).size.width,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             widget.loading
  //                 ? RegularText(text: 'Loading', dark: true)
  //                 : BiggerArabicText(
  //                     text: widget.quiz.arab,
  //                     dark: true,
  //                     bold: true,
  //                   )
  //           ],
  //         ),
  //       ),
  //       Positioned(
  //         bottom: 20.0,
  //         right: 20.0,
  //         child: Container(
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
  //           decoration: BoxDecoration(
  //             color: redColor,
  //             borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //           ),
  //           child: SmallerText(
  //             text: widget.point.toString(),
  //             dark: false,
  //           ),
  //         ),
  //       ),
  //       Positioned(
  //         top: 20.0,
  //         right: 20.0,
  //         child: GestureDetector(
  //           onTap: play,
  //           child: Icon(
  //             Icons.volume_up,
  //             color: greyColorLight,
  //             size: 40.0,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Material(
            elevation: 2.0,
            color: Colors.grey[200],
            child: new Center(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new Material(child: _buildPlayer()),
                    localFilePath != null
                        ? new Text(localFilePath)
                        : new Container(),
                    new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new RaisedButton(
                              onPressed: () => _loadFile(),
                              child: new Text('Download'),
                            ),
                            new RaisedButton(
                              onPressed: () => _playLocal(),
                              child: new Text('play local'),
                            ),
                          ]),
                    )
                  ]),
            )));
  }

  Widget _buildPlayer() => new Container(
      padding: new EdgeInsets.all(1.0),
      child: new Column(mainAxisSize: MainAxisSize.min, children: [
        new Row(mainAxisSize: MainAxisSize.min, children: [
          new IconButton(
              onPressed: isPlaying ? null : () => play(),
              iconSize: 20.0,
              icon: new Icon(Icons.play_arrow),
              color: Colors.cyan),
          new IconButton(
              onPressed: isPlaying ? () => pause() : null,
              iconSize: 20.0,
              icon: new Icon(Icons.pause),
              color: Colors.cyan),
          new IconButton(
              onPressed: isPlaying || isPaused ? () => stop() : null,
              iconSize: 20.0,
              icon: new Icon(Icons.stop),
              color: Colors.cyan),
        ]),
        duration == null
            ? new Container()
            : new Slider(
                value: position?.inMilliseconds?.toDouble() ?? 0.0,
                onChanged: (double value) =>
                    audioPlayer.seek((value / 1000).roundToDouble()),
                min: 0.0,
                max: duration.inMilliseconds.toDouble()),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new IconButton(
                onPressed: () => mute(true),
                icon: new Icon(Icons.headset_off),
                color: Colors.cyan),
            new IconButton(
                onPressed: () => mute(false),
                icon: new Icon(Icons.headset),
                color: Colors.cyan),
          ],
        ),
        new Row(mainAxisSize: MainAxisSize.min, children: [
          new Padding(
              padding: new EdgeInsets.all(12.0),
              child: new Stack(children: [
                new CircularProgressIndicator(
                    value: 1.0,
                    valueColor: new AlwaysStoppedAnimation(Colors.grey[300])),
                new CircularProgressIndicator(
                  value: position != null && position.inMilliseconds > 0
                      ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
                          (duration?.inMilliseconds?.toDouble() ?? 0.0)
                      : 0.0,
                  valueColor: new AlwaysStoppedAnimation(Colors.cyan),
                  backgroundColor: Colors.yellow,
                ),
              ])),
          new Text(
              position != null
                  ? "${positionText ?? ''} / ${durationText ?? ''}"
                  : duration != null ? durationText : '',
              style: new TextStyle(fontSize: 24.0))
        ])
      ]));
}
