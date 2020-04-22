import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/battle_list/bloc/battle_list_bloc.dart';

class CountBattle extends StatefulWidget {
  const CountBattle({Key key}) : super(key: key);

  @override
  _CountBattleState createState() => _CountBattleState();
}

class _CountBattleState extends State<CountBattle> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BattleListBloc>(context).add(GetAllBattleAvtiveCount());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BattleListBloc, BattleListState>(
      builder: (ctx, state) {
        if (state is HasBattleList && state.quizBattle.isNotEmpty  && state.isComplete) {
          return Container(
            decoration:
                const BoxDecoration(color: redColor, shape: BoxShape.circle),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmallerText(
                  text: state.quizBattle.length.toString(),
                  dark: false,
                )
              ],
            ),
          );
        }
        return const SizedBox(width: 0);
      },
    );
  }
}
