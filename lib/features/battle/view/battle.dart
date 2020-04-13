import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';

import 'package:karbarab/features/battle/bloc/battle_bloc.dart';
import 'package:karbarab/features/battle/view/gamemode_chooser.dart';
import 'package:karbarab/features/battle/view/quiz_chooser.dart';
import 'package:karbarab/features/battle/view/user_chooser.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/model/user.dart';

enum SelectedType { Quiz, User, Mode }

class BattleScreen extends StatefulWidget {
  static const String routeName = '/card-battle';

  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  Quiz quizSelected;
  User userSelected;
  GameMode gameModeSelected;

  SelectedType mode;

  void _onChangeMode(SelectedType type, context) {
    setState(() {
      mode = type;
    });
    _choose(context);
  }

  void _send() {
    BlocProvider.of<BattleBloc>(context).add(SendCard(
      gameMode: gameModeSelected,
      quiz: quizSelected,
      userReciever: userSelected,
    ));
  }

  void _setSelected(SelectedType type, dynamic value) {
    switch (type) {
      case SelectedType.Mode:
        setState(() {
          gameModeSelected = value;
        });
        break;
      case SelectedType.Quiz:
        setState(() {
          quizSelected = value;
        });
        break;
      case SelectedType.User:
        setState(() {
          userSelected = value;
        });
        break;
      default:
    }
  }

  bool get _isCompleteField {
    return quizSelected is Quiz &&
        userSelected is User &&
        gameModeSelected is GameMode;
  }

  Widget get _buildContent {
    switch (mode) {
      case SelectedType.Mode:
        return GameModeChooser(
          onSelect: (GameMode gameMode) {
            _setSelected(SelectedType.Mode, gameMode);
          },
        );
      case SelectedType.Quiz:
        return QuizChooser(
          onSelect: (Quiz quiz) {
            _setSelected(SelectedType.Quiz, quiz);
          },
        );
      case SelectedType.User:
        return UserChooser(
          onSelect: (User user) {
            _setSelected(SelectedType.User, user);
          },
        );
      default:
    }
    return GameModeChooser(
      onSelect: (GameMode gameMode) {
        _setSelected(SelectedType.Mode, gameMode);
      },
    );
  }

  void _choose(BuildContext _) {
    Navigator.of(_).push(FullScreenModal(_buildContent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: <Widget>[
          BlocBuilder<BattleBloc, BattleState>(
            builder: (c, s) {
              if (s is SendCardState && s.isLoading) {
                return const Text('wait..');
              }
              if (s is SendCardState && s.isFailure) {
                return const Text('gagal..');
              }
              if (s is SendCardState && s.isSuccess) {
                return const Text('success..');
              }
              return const SizedBox(width: 0);
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage('assets/images/card_logo.png'),
                height: 20,
              ),
              const SizedBox(width: 20),
              BiggerText(
                text: 'Kirim Kartu!',
                color: greenColor,
                bold: true,
                // dark: true,
              ),
              const SizedBox(width: 20),
              const Image(
                image: AssetImage('assets/images/card_logo.png'),
                height: 20,
              ),
            ],
          ),
          Column(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(color: greenColor, width: 2)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RegularText(
                        text: quizSelected != null
                            ? quizSelected.bahasa
                            : 'Silahkan Pilih',
                      ),
                      FlatButton(
                        child: RegularText(
                          text: 'Pilih',
                          color: secondaryColor,
                        ),
                        onPressed: () {
                          _onChangeMode(SelectedType.Quiz, context);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(color: greenColor, width: 2)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RegularText(
                        text: userSelected != null
                            ? userSelected.username
                            : 'Silahkan Pilih',
                      ),
                      FlatButton(
                        child: RegularText(
                          text: 'Pilih',
                          color: secondaryColor,
                        ),
                        onPressed: () {
                          _onChangeMode(SelectedType.User, context);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(color: greenColor, width: 2)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RegularText(
                        text: gameModeSelected != null
                            ? GameModeHelper.stringOf(gameModeSelected)
                            : 'Silahkan Pilih',
                      ),
                      FlatButton(
                        child: RegularText(
                          text: 'Pilih',
                          color: secondaryColor,
                        ),
                        onPressed: () {
                          _onChangeMode(SelectedType.Mode, context);
                        },
                      )
                    ],
                  ),
                ),
              ),
              RaisedButton(
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                onPressed: _isCompleteField ? _send : null,
                color:
                    _isCompleteField ? greenColor : greenColor.withOpacity(0.6),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // side: BorderSide(color: greenColor, width: 2),
                ),
                child: RegularText(
                  text: 'Kirim Sekarang!',
                  bold: true,
                  dark: false,
                ),

                // disabled: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RowContainer extends StatelessWidget {
  final String label;
  final String value;
  RowContainer({@required this.label, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: greyColor,
            width: (0.2 * MediaQuery.of(context).size.width) - 20,
            padding: const EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SmallerText(
                dark: false,
                text: '$label',
              ),
            ),
          ),
          Container(
            color: greyColorLight,
            width: (0.8 * MediaQuery.of(context).size.width) - 20,
            padding: const EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: BoldRegularText(
                text: value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenModal extends ModalRoute<void> {
  final Widget modal;
  FullScreenModal(this.modal);
  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.white;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
      // make sure that the overlay content is not cut off
      // child: SafeArea(
      //   child: _buildOverlayContent(context),
      // ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return modal;
    // return Center(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       modal,
    //       // RaisedButton(
    //       //   onPressed: () => Navigator.pop(context),
    //       //   child: Text('Dismiss'),
    //       // )
    //     ],
    //   ),
    // );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
