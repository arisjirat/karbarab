import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:karbarab/core/config/ads.dart';
import 'package:karbarab/features/admob/bloc/admob_bloc.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/utils/flavors.dart';
import 'package:karbarab/utils/logger.dart';

class AdsScreen extends StatefulWidget {
  final AdsMode adsMode;
  final Function onReward;
  final Quiz quiz;
  final Widget buttonShow;
  AdsScreen({
    @required this.adsMode,
    @required this.onReward,
    this.quiz,
    this.buttonShow = const Text('Ads Show'),
  });
  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: ADMOB_PUBLISHER_ID != null ? <String>[ADMOB_PUBLISHER_ID] : null,
    keywords: ADMOB_KEYWORDS,
  );

  void showAds() {

    if (widget.adsMode == AdsMode.GlOBAL_SCORE) {
      print('$ADMOB_APP_ID/${DotEnv().env['ADMOB_ADS_SCORE']}');
      RewardedVideoAd.instance
          .load(
        adUnitId: FlavorConfig.isProduction() ? '$ADMOB_APP_ID/${DotEnv().env['ADMOB_ADS_SCORE']}' : RewardedVideoAd.testAdUnitId,
        targetingInfo: targetingInfo,
      )
          .then((l) {
        BlocProvider.of<AdmobBloc>(context).add(AdsLoaded());
      }).catchError((e) {
        Logger.e('error', e: e, s: StackTrace.current);
      });
    }

    if (widget.adsMode == AdsMode.HINT) {
      RewardedVideoAd.instance
          .load(
        adUnitId: FlavorConfig.isProduction() ? '$ADMOB_APP_ID/${DotEnv().env['ADMOB_ADS_HINT']}' : RewardedVideoAd.testAdUnitId,
        targetingInfo: targetingInfo,
      )
          .then((l) {
        BlocProvider.of<AdmobBloc>(context).add(AdsLoaded());
      }).catchError((e) {
        Logger.e('error', e: e, s: StackTrace.current);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FlavorConfig.isProduction() ? ADMOB_PUBLISHER_ID : FirebaseAdMob.testAppId);
    RewardedVideoAd.instance.listener = (
      RewardedVideoAdEvent event, {
      String rewardType,
      int rewardAmount,
    }) {
      if (event == RewardedVideoAdEvent.rewarded) {
        BlocProvider.of<AdmobBloc>(context).add(UserAdsrewards(
          adsMode: widget.adsMode,
          coin: rewardAmount,
          quizId: widget.quiz != null ? widget.quiz.id : '',
        ));
        widget.onReward();
      }
      if (event == RewardedVideoAdEvent.loaded) {
        BlocProvider.of<AdmobBloc>(context).add(AdsLoaded());
      }
      if (event == RewardedVideoAdEvent.closed) {
        BlocProvider.of<AdmobBloc>(context).add(AdsClosed());
        showAds();
      }
      if (event == RewardedVideoAdEvent.failedToLoad) {
        BlocProvider.of<AdmobBloc>(context).add(AdsFailedLoad());
        // force to reward
        if (widget.adsMode == AdsMode.GlOBAL_SCORE) {
          widget.onReward();
        }
      }
    };
    showAds();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdmobBloc, AdmobState>(builder: (context, snapshot) {
      if (snapshot is AdmobState &&
          snapshot.isRewardedLoaded) {
        return GestureDetector(
          onTap: () {
            RewardedVideoAd.instance.show();
          },
          child: widget.buttonShow,
        );
      }
      return const SizedBox(width: 0);
    });
  }
}
