import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';
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

  Color getColor(int position) {
    switch (position) {
      case 0:
        return yellowColor;
      case 1:
        return greyColor;
      case 2:
        return brownColor;
      default:
        return blueColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      color: greyColorLight,
      child: BlocBuilder<GlobalScoresBloc, GlobalScoresState>(
        builder: (context, state) {
          if (state is GlobalHasScores) {
            return ListView.builder(
              itemCount: state.all.length,
              itemBuilder: (context, position) {
                final score = state.all[position];
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                score.metaUser.avatar,
                              ),
                              radius: 20,
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RegularText(
                                  text: score.metaUser.fullname,
                                  dark: true,
                                ),
                                BoldRegularText(
                                  text: score.score.toString(),
                                  dark: true,
                                  color: greenColor,
                                ),
                              ],
                            )
                          ],
                        ),
                        Icon(
                          Icons.stars,
                          color: getColor(position),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return SpinKitRotatingPlain(color: greenColor);
        },
      ),
    );
  }
}
