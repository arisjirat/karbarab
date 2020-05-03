import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:karbarab/core/config/ads.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/goin.dart';
import 'package:karbarab/utils/flavors.dart';

class AdsBanner extends StatefulWidget {
  static String routeName = '/banner';
  AdsBanner({Key key}) : super(key: key);

  @override
  _AdsBannerState createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices:
        ADMOB_PUBLISHER_ID != null ? <String>[ADMOB_PUBLISHER_ID] : null,
    keywords: ADMOB_KEYWORDS,
  );

  int loadedAds = 0;
  int gap = 0;
  Timer showTime;
  List<BannerAd> listBannerAd = [];

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: FlavorConfig.isProduction() ? 'ca-app-pub-7945031394108607/9038080444' : BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print('event: $event');
        if (event == MobileAdEvent.loaded) {
          setState(() {
            loadedAds = loadedAds + 1;
          });
        }
      },
    );
  }

  void showAllBannerAd() {
    final double height = 90;
    for (var i = 0; i < 5; i++) {
      listBannerAd.add(createBannerAd());
      listBannerAd[i]
        ..load()
        ..show(
          anchorType: AnchorType.top,
          horizontalCenterOffset: 20,
          anchorOffset: height * (i + 1),
        );
    }
  }

  void destroyAllBanner() {
    for (var i = 0; i < listBannerAd.length; i++) {
      listBannerAd[i].dispose();
    }
    listBannerAd = [];
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: FlavorConfig.isProduction() ? ADMOB_PUBLISHER_ID : FirebaseAdMob.testAppId);
    showAllBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    destroyAllBanner();
    showTime.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loadedAds > 0 && loadedAds % 5 == 0) {
      showTime = Timer(Duration(seconds: 10 + gap), () {
        destroyAllBanner();
        Future.delayed(const Duration(seconds: 1), () {
          gap += 1;
          showAllBannerAd();
        });
      });
    }
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('AdsBan'),
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
                    Text('Loaded: $loadedAds'),
                    RaisedButton(
                        child: const Text('REMOVE BANNER'),
                        onPressed: () {
                          destroyAllBanner();
                        }),
                    RaisedButton(
                        color: redColor,
                        child: const Text('Gow'),
                        onPressed: () {
                          destroyAllBanner();
                          showTime.cancel();
                          Navigator.of(context).pushNamed(Goin.routeName);
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
