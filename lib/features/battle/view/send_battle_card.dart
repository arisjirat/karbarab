import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';

import 'package:karbarab/features/battle/bloc/battle_bloc.dart';
import 'package:karbarab/features/battle/view/gamemode_chooser.dart';
import 'package:karbarab/features/battle/view/quiz_chooser.dart';
import 'package:karbarab/features/battle/view/user_chooser.dart';
import 'package:karbarab/features/send_card_limit/bloc/send_card_limit_bloc.dart';
import 'package:karbarab/features/send_card_limit/view/send_card_limit_view.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/model/user.dart';

enum SelectedType { Quiz, User, Mode }

class SendBattleCard extends StatefulWidget {
  @override
  _SendBattleCardState createState() => _SendBattleCardState();
}

class _SendBattleCardState extends State<SendBattleCard> {
  Quiz quizSelected;
  User userSelected;
  GameMode gameModeSelected;

  Timer time;

  SelectedType mode;

  void _onChangeMode(SelectedType type, context, {payloadImage = false}) {
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
          quiz: quizSelected,
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
      quiz: quizSelected,
      onSelect: (GameMode gameMode) {
        _setSelected(SelectedType.Mode, gameMode);
      },
    );
  }

  void _choose(BuildContext _) {
    Navigator.of(_).push(FullScreenModal(_buildContent));
  }

  @override
  void dispose() {
    super.dispose();
    if (time != null) {
      time.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          BlocListener<BattleBloc, BattleState>(
            listener: (c, state) {
              if (state is SendCardState && state.isSuccess) {
                BlocProvider.of<SendCardLimitBloc>(context)
                    .add(GetSendCardLimit());
                time = Timer(const Duration(seconds: 3), () {
                  BlocProvider.of<BattleBloc>(context)
                      .add(ResetSendCardState());
                });
                setState(() {
                  gameModeSelected = null;
                  quizSelected = null;
                  userSelected = null;
                });
              }
            },
            child: const SizedBox(width: 0),
          ),
          SendCardLimitView(),
          BlocBuilder<BattleBloc, BattleState>(
            builder: (c, s) {
              Widget stateWidget = const SizedBox(
                width: 0,
              );
              if (s is SendCardState && s.isLoading) {
                stateWidget = RegularText(
                  text: 'Sedang mengirim..',
                );
              }
              if (s is SendCardState && s.isFailure) {
                stateWidget = RegularText(
                  text: 'Gagal mengirim kartu',
                );
              }
              if (s is SendCardState && s.isSuccess) {
                stateWidget = RegularText(
                  text: 'Berhasil kirim kartu',
                );
              }
              return BlocBuilder<SendCardLimitBloc, SendCardLimitState>(
                  builder: (ctx, snapshot) {
                if (snapshot is HasSendCardLimit && snapshot.limit > 0) {
                  return Column(children: [
                    stateWidget,
                    const SizedBox(height: 30),
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
                            quizSelected != null
                                ? Row(
                                    children: <Widget>[
                                      RegularText(
                                        text: 'Kartu: ',
                                        color: greyColor.withOpacity(0.8),
                                      ),
                                      RegularText(
                                        text: quizSelected.bahasa,
                                        bold: true,
                                        dark: true,
                                      ),
                                    ],
                                  )
                                : RegularText(
                                    text: 'Pilih Kartunya',
                                    color: greyColor.withOpacity(0.8),
                                  ),
                            MaterialButton(
                              color: secondaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: RegularText(
                                text: quizSelected != null ? 'Ganti' : 'Pilih',
                                // color: whiteColor,
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
                            userSelected != null
                                ? Row(
                                    children: <Widget>[
                                      RegularText(
                                        text: 'Lawan: ',
                                        color: greyColor.withOpacity(0.8),
                                      ),
                                      userSelected.avatar != null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                userSelected.avatar,
                                              ),
                                              radius: 20,
                                              backgroundColor:
                                                  Colors.transparent,
                                            )
                                          : const CircleAvatar(
                                              radius: 20,
                                              backgroundColor: whiteColor,
                                              backgroundImage: AssetImage(
                                                  'assets/images/character.png'),
                                            ),
                                      const SizedBox(width: 10),
                                      RegularText(
                                        text: userSelected.username,
                                        bold: true,
                                        dark: true,
                                      ),
                                    ],
                                  )
                                : RegularText(
                                    text: 'Pilih Lawan',
                                    color: greyColor.withOpacity(0.8),
                                  ),
                            MaterialButton(
                              color: secondaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: RegularText(
                                text: userSelected != null ? 'Ganti' : 'Pilih',
                              ),
                              onPressed: () {
                                _onChangeMode(SelectedType.User, context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    quizSelected != null
                        ? Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: greenColor, width: 2)),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  gameModeSelected != null
                                      ? Row(
                                          children: <Widget>[
                                            RegularText(
                                              text: 'Mode: ',
                                              color: greyColor.withOpacity(0.8),
                                            ),
                                            RegularText(
                                              text: GameModeHelper.stringOf(
                                                  gameModeSelected),
                                              bold: true,
                                              dark: true,
                                            ),
                                          ],
                                        )
                                      : RegularText(
                                          text: 'Pilih Mode',
                                          color: greyColor.withOpacity(0.8),
                                        ),
                                  MaterialButton(
                                    color: secondaryColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: RegularText(
                                      text: gameModeSelected != null
                                          ? 'Ganti'
                                          : 'Pilih',
                                      // color: whiteColor,
                                    ),
                                    onPressed: () {
                                      _onChangeMode(SelectedType.Mode, context);
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(width: 0),
                    const SizedBox(height: 20),
                    RaisedButton(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 15),
                      onPressed: (s is SendCardState &&
                              !s.isLoading &&
                              _isCompleteField)
                          ? _send
                          : null,
                      color: (s is SendCardState &&
                              !s.isLoading &&
                              _isCompleteField)
                          ? greenColor
                          : greenColor.withOpacity(0.6),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: RegularText(
                        text: 'Kirim Sekarang!',
                        bold: true,
                        dark: false,
                      ),
                    ),
                  ]);
                }
                return const SizedBox(width: 0);
              });
            },
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
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return modal;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
