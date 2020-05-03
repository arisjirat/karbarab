import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:karbarab/core/config/ads.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/utils/flavors.dart';

class Goin extends StatefulWidget {
  static String routeName = '/goin';
  Goin({Key key}) : super(key: key);

  @override
  _GoinState createState() => _GoinState();
}

class _GoinState extends State<Goin> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices:
        ADMOB_PUBLISHER_ID != null ? <String>[ADMOB_PUBLISHER_ID] : null,
    keywords: ADMOB_KEYWORDS,
  );

  int loadedAds = 0;
  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: FlavorConfig.isProduction() ? 'ca-app-pub-7945031394108607/1381886047' : BannerAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: FlavorConfig.isProduction() ? ADMOB_PUBLISHER_ID : FirebaseAdMob.testAppId);
    _interstitialAd = createInterstitialAd()..load();
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('AdsIn'),
            actions: [
              MaterialButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: secondaryColor,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.backspace),
                ),
                elevation: 5,
              ),
            ],
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: (90 * 6).toDouble(),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RaisedButton(
                        child: const Text('GOWGOW'),
                        onPressed: () {
                         _interstitialAd?.show();
                        }),
                  ].map((Widget button) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: button,
                    );
                  }).toList(),
                ),
              ),
            ],
          ))),
    );
  }
}
