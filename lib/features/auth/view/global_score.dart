import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/ads.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/config/keywords_ads.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/helper/hasInternet.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/admob/bloc/admob_bloc.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';

class GlobalScore extends StatefulWidget {
  @override
  _GlobalScoreState createState() => _GlobalScoreState();
}

class _GlobalScoreState extends State<GlobalScore> with WidgetsBindingObserver {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: APP_ID != null ? <String>[APP_ID] : null,
    keywords: KEYWORDS,
  );

  bool _adsLoaded = false;
  bool _watched = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print('RewardedVideoAd event $event');
      if (event == RewardedVideoAdEvent.rewarded) {
        BlocProvider.of<AdmobBloc>(context).add(UserAdsrewards(adsMode: 'global-score'));
        BlocProvider.of<GlobalScoresBloc>(context).add(GetGlobalScores());
        setState(() {
          _watched = true;
          _adsLoaded = false;
        });
      }
      if (event == RewardedVideoAdEvent.loaded) {
        setState(() {
          _adsLoaded = true;
        });
      }
      if (event == RewardedVideoAdEvent.closed && _adsLoaded) {
        _loadRewardsScore();
      }
    };

    _loadRewardsScore();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _watched = false;
    });
  }

  void _loadRewardsScore() {
    setState(() {
      _adsLoaded = false;
    });
    RewardedVideoAd.instance
        .load(
      adUnitId: 'ca-app-pub-8844883376001707/4809848402',
      // adUnitId: RewardedVideoAd.testAdUnitId,
      targetingInfo: targetingInfo,
    )
        .then((e) {
      setState(() {
        _adsLoaded = e;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      checkConnectionFirst(_loadRewardsScore, context);
    }
  }

  void _getScore() async {
    checkConnectionFirst(RewardedVideoAd.instance.show, context);
  }

  Color getColor(int position) {
    switch (position) {
      case 0:
        return yellowColor;
      case 1:
        return greyColor;
      case 2:
        return brownColor;
      default:
        return greyColorLight;
    }
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
                const SizedBox(height: 20,),
                RawMaterialButton(
                  onPressed: () {
                    _getScore();
                  },
                  child: Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: greenColor,
                  padding: const EdgeInsets.all(15.0),
                )
              ],
            );
          } else if (state is GlobalHasScores) {
            return ListView.builder(
              itemCount: state.all.length,
              itemBuilder: (context, position) {
                final score = state.all[position];
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                score.metaUser.avatar,
                              ),
                              radius: 20,
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RegularText(
                                  text: score.metaUser.fullname,
                                  dark: true,
                                ),
                                BoldRegularText(
                                  text: score.score.toString(),
                                  dark: false,
                                  color: greenColor,
                                ),
                              ],
                            )
                          ],
                        ),
                        Icon(
                          Icons.stars,
                          color: getColor(position),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SpinKitRotatingPlain(color: greenColor);
        },
      ),
    );
  }
}
