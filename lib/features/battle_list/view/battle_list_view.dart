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
      padding: const EdgeInsets.all(20),
      child:
          BlocBuilder<BattleListBloc, BattleListState>(builder: (ctx, state) {
        if (state is HasBattleList) {
          if (state.isLoading) {
            return SpinKitDoubleBounce(color: greenColor);
          }
          if (state.quizBattle.isNotEmpty) {
            return ListView.builder(
              itemCount: state.quizBattle.length,
              itemBuilder: (context, position) {
                return CardBattleItem(
                  onAnswer: () {
                    Navigator.push(
                      ctx,
                      MaterialPageRoute(
                        builder: (ct) => BattleAnswerScreen(battle: state.quizBattle[position],),
                      ),
                    );
                  },
                  key: Key(state.quizBattle[position].scoreId),
                  score: state.quizBattle[position],
                );
              },
            );
          } else if (state.quizBattle.isEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RegularText(text: 'Tidak ada kartu',)
              ],
            );
          }
        }
        return SpinKitDoubleBounce(color: greenColor);
      }),
    );
  }
}
