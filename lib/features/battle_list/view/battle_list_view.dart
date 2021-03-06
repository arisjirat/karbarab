import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/cards/card_battle_item.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/battle_list/bloc/battle_list_bloc.dart';
import 'package:karbarab/features/quiz/view/battle_answer_screen.dart';

class BattleListView extends StatefulWidget {
  BattleListView();

  @override
  _BattleListViewState createState() => _BattleListViewState();
}

class _BattleListViewState extends State<BattleListView> {
  @override
  void initState() {
    BlocProvider.of<BattleListBloc>(context).add(GetBattleList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocListener<BattleListBloc, BattleListState>(
        listener: (ctx, state) {
          // force request user null
          if (state is HasBattleList &&
              state.quizBattle.isNotEmpty &&
              state.user == null) {
            // Future.delayed(const Duration(milliseconds: 100), () {
              // BlocProvider.of<BattleListBloc>(context).add(GetBattleList());
            // });
          }
        },
        child: BlocBuilder<BattleListBloc, BattleListState>(
          builder: (ctx, state) {
            if (state is HasBattleList) {
              if (state.isLoading) {
                return const SpinKitDoubleBounce(color: greenColor);
              }
              if (state.quizBattle.isNotEmpty && state.user != null) {
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: state.quizBattle.length,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CardBattleItem(
                        user: state.user,
                        onAnswer: () {
                          Navigator.push(
                            ctx,
                            MaterialPageRoute(
                              builder: (ct) => BattleAnswerScreen(
                                battle: state.quizBattle[position],
                              ),
                            ),
                          );
                        },
                        key: Key(state.quizBattle[position].scoreId),
                        score: state.quizBattle[position],
                      ),
                    );
                  },
                );
              } else if (state.quizBattle.isEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RegularText(
                      text: 'Tidak ada kartu kiriman',
                    )
                  ],
                );
              }
            }
            return const SpinKitDoubleBounce(color: greenColor);
          },
        ),
      ),
    );
  }
}
