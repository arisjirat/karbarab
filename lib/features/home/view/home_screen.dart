import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/greetings.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/features/auth/view/profile_screen.dart';
import 'package:karbarab/core/ui/cards/card_play.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/core/helper/scale_calculator.dart';
import 'package:karbarab/features/score/bloc/score_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayName = '';
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ScoreBloc>(context).add(GetScoreUserByMode());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    SnackBar(
      content: RegularText(
        text: 'Tekan 2 kali untuk keluar',
      ),
    );
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 3000),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: whiteColor.withOpacity(0.8),
                ),
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.center,
                  child: SmallerText(
                    dark: true,
                    text: 'Tekan 2 kali untuk keluar',
                  ),
                ),
              )
            ],
          ),
        ),
      ));
      // Fluttertoast.showToast(msg: exit_warning);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    final double _deviceHeight = MediaQuery.of(context).size.height - padding;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                if (state is Authenticated) {
                  return Hero(
                    deviceHeight: _deviceHeight,
                    displayName: state.displayName,
                  );
                }
                return Hero(
                  deviceHeight: _deviceHeight,
                  displayName: '',
                );
              }),
              BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
                return Container(
                  height: 0.7 * _deviceHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardPlay(
                        color: greenColor,
                        secondaryColor: greenColorLight,
                        title: 'Gambar Dalam Bahasa Arab',
                        loadScore: state is HasScore && state.loadScore,
                        score: state is HasScore ? state.scoreGambarArab : 0,
                        mode: GameMode.GambarArab,
                      ),
                      Container(height: scaleCalculator(20.0, context)),
                      CardPlay(
                        color: blueColor,
                        secondaryColor: blueColorLight,
                        title: 'Bahasa Arab Dalam Gambar',
                        loadScore: state is HasScore && state.loadScore,
                        score: state is HasScore ? state.scoreArabGambar : 0,
                        mode: GameMode.ArabGambar,
                      ),
                      Container(height: scaleCalculator(20.0, context)),
                      CardPlay(
                        color: redColor,
                        secondaryColor: redColorLight,
                        title: 'Kata Dalam Bahasa Arab',
                        loadScore: state is HasScore && state.loadScore,
                        score: state is HasScore ? state.scoreKataArab : 0,
                        mode: GameMode.KataArab,
                      ),
                      Container(height: scaleCalculator(20.0, context)),
                      CardPlay(
                        color: yellowColor,
                        secondaryColor: yellowColorDark,
                        title: 'Bahasa Arab dalam kata',
                        loadScore: state is HasScore && state.loadScore,
                        score: state is HasScore ? state.scoreArabKata : 0,
                        mode: GameMode.ArabKata,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class Hero extends StatelessWidget {
  final double deviceHeight;
  final String displayName;

  Hero({this.deviceHeight, @required this.displayName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 0.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: greenColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5.0),
          height: (0.3 * deviceHeight) - 5.0,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('assets/images/card_logo.png'),
                      height: deviceHeight / 10,
                    ),
                    LogoText(text: 'Karbarab', dark: true),
                    RegularText(
                        text: 'Hai, Selamat ${greeting()} $displayName',
                        dark: true),
                    ArabicText(text: 'مرحبا مساء الخير', dark: true),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 10.0,
                child: Image(
                  image: const AssetImage('assets/images/character.png'),
                  height: deviceHeight / 8,
                ),
              ),
              Positioned(
                top: 15.0,
                right: 15.0,
                child: IconButton(
                  icon: Icon(
                    Icons.person_outline,
                    color: greyColor,
                    size: 40.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
