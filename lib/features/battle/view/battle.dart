import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/core/ui/button.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/features/battle/view/gamemode_chooser.dart';
import 'package:karbarab/features/battle/view/quiz_chooser.dart';
import 'package:karbarab/features/battle/view/user_chooser.dart';
import 'package:karbarab/features/quiz/bloc/quiz_bloc.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';

enum SelectedType { Quiz, User, Mode }

class BattleScreen extends StatefulWidget {
  static const String routeName = '/card-battle';

  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  QuizModel quizSelected;
  UserModel userSelected;
  GameMode gameModeSelected;

  SelectedType mode;

  void _onChangeMode(SelectedType type) {
    setState(() {
      mode = type;
    });
    _choose();
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

  Widget get _buildContent {
    switch (mode) {
      case SelectedType.Mode:
        return GameModeChooser();
      case SelectedType.Quiz:
        return QuizChooser();
      case SelectedType.User:
        return UserChooser();
      default:
    }
    return GameModeChooser();
  }

  void _choose() {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          titlePadding: const EdgeInsets.all(0),
          content: _buildContent,
          actions: <Widget>[],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: <Widget>[
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
                        text: quizSelected != null ? quizSelected.bahasa : 'Silahkan Pilih',
                      ),
                      FlatButton(
                        child: RegularText(
                          text: 'Pilih',
                          color: secondaryColor,
                        ),
                        onPressed: () {
                          _onChangeMode(SelectedType.Quiz);
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
                        text: userSelected != null ? userSelected.username : 'Silahkan Pilih',
                      ),
                      FlatButton(
                        child: RegularText(
                          text: 'Pilih',
                          color: secondaryColor,
                        ),
                        onPressed: () {
                          _onChangeMode(SelectedType.User);
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
                        text: gameModeSelected != null ? gameModeToString(gameModeSelected) : 'Silahkan Pilih',
                      ),
                      FlatButton(
                        child: RegularText(
                          text: 'Pilih',
                          color: secondaryColor,
                        ),
                        onPressed: () {
                          _onChangeMode(SelectedType.Mode);
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
                onPressed: () {},
                color: greenColor,
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
