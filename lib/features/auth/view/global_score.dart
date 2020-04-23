import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/admob/bloc/admob_bloc.dart';
import 'package:karbarab/features/admob/view/ads.dart';
import 'package:karbarab/features/auth/view/card_score_item.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const LAST_TIME_WATCH_ADS = 'last_time_watch_ads';

class GlobalScore extends StatefulWidget {
  @override
  _GlobalScoreState createState() => _GlobalScoreState();
}

class _GlobalScoreState extends State<GlobalScore> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _watched = false;
  bool _checking = false;

  void _handleReward() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(LAST_TIME_WATCH_ADS,
        DateTime.now().add(const Duration(minutes: 15)).millisecondsSinceEpoch);
    setState(() {
      _watched = true;
    });
  }

  void _isNeedToWatchAgain() async {
    final SharedPreferences prefs = await _prefs;
    final int lastWatch = prefs.getInt(LAST_TIME_WATCH_ADS);
    if (lastWatch != null && DateTime.fromMillisecondsSinceEpoch(lastWatch)
        .isAfter(DateTime.now())) {
      print('is after');
      setState(() {
        _watched = true;
        _checking = false;
      });
    } else {
      setState(() {
        _watched = false;
        _checking = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GlobalScoresBloc>(context).add(GetGlobalScores());
    _isNeedToWatchAgain();
    setState(() {
      _checking = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isNeedToWatchAgain();
    setState(() {
      _checking = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      color: greyColorLight,
      child: BlocBuilder<GlobalScoresBloc, GlobalScoresState>(
        builder: (context, state) {
          if (!_watched) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: const AssetImage('assets/images/character.png'),
                    height: deviceHeight(context) / 5,
                  ),
                ),
                !_checking
                    ? Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: RegularText(
                              text: 'Mau lihat score global?',
                              dark: true,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: RegularText(
                              text: 'Tonton iklan dulu yuk',
                              dark: true,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AdsScreen(
                            adsMode: AdsMode.GlOBAL_SCORE,
                            onReward: _handleReward,
                            buttonShow: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greenColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: textColor.withOpacity(0.5),
                                    offset: const Offset(0.0, 0.0),
                                  ),
                                  BoxShadow(
                                    color: textColor.withOpacity(0.5),
                                    offset: const Offset(0.0, 0.1),
                                    spreadRadius: -2.0,
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.play_circle_outline,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SpinKitDoubleBounce(color: greenColor),
              ],
            );
          } else if (state is GlobalHasScores) {
            return ListView.builder(
              itemCount: state.all.length,
              itemBuilder: (context, position) {
                final score = state.all[position];
                return CardScoreItem(score: score, tier: position + 1);
              },
            );
          }
          return const SpinKitDoubleBounce(color: greenColor);
        },
      ),
    );
  }
}
