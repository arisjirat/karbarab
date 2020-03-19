import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';

class GlobalScore extends StatefulWidget {

  @override
  _GlobalScoreState createState() => _GlobalScoreState();
}

class _GlobalScoreState extends State<GlobalScore> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<GlobalScoresBloc>(context).add(GetGlobalScores());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
      color: greyColorLight,
      child: BlocBuilder<GlobalScoresBloc, GlobalScoresState>(
        builder: (context, state) {
          if (state is GlobalHasScores) {
            return Column(
              children: state.all.map((e) {
                return Container(
                  width: double.infinity,
                  height: 100,
                  child: Row(children: <Widget>[
                    Text(e.userMail),
                    Text(e.score.toString())
                  ],),
                );
              }).toList()
            );
          }
          return const Text('sad');
        },
      ),
    );
  }
}
